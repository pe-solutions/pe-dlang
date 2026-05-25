# Tier 2 Library Candidates — Decision Document

Analysis of the nine candidates identified in the 2026-05-25 library audit.
Each entry covers: proposed signature, genericity rationale, migration effort, and recommendation.

---

## Design Highlight: `digitReduce` — D Meta-Programming Building Block

Before individual candidates, one cross-cutting insight: three digit-accumulation
functions (`digitSum`, `digitSquareSum`, `digitFactSum`) share an identical loop
skeleton. D's compile-time `alias` template parameter lets us factor it out at zero
runtime cost:

```d
// Public building block — alias f maps a single digit (0–9) to a value.
// Instantiated at compile time; no runtime function-pointer overhead.
T digitReduce(alias f, T)(T n) pure nothrow @nogc if (isIntegral!T) {
    Unqual!T s = 0, m = cast(Unqual!T)n;
    while (m > 0) { s += cast(Unqual!T)f(cast(int)(m % 10)); m /= 10; }
    return s;
}

// Wrappers — each compiles to a tight inlined loop, identical to hand-written.
T digitSum(T)(T n)       pure nothrow @nogc if (isIntegral!T) { return digitReduce!(d => d      )(n); }
T digitSquareSum(T)(T n) pure nothrow @nogc if (isIntegral!T) { return digitReduce!(d => d * d  )(n); }
```

`digitFactSum` gets an internal refactor (no API change); the lookup table is lifted
to module scope to avoid the lambda closing over a function-local static:

```d
private static immutable int[10] _digitFact = [1,1,2,6,24,120,720,5_040,40_320,362_880];

T digitFactSum(T)(T n) pure nothrow @nogc if (isIntegral!T) {
    return digitReduce!(d => _digitFact[d])(n);
}
```

`digitReduce` itself is **public** — user-defined digit transforms (e.g. `d => d*d*d`
for digit-cube sums) collapse to a one-liner at call sites rather than a new helper.

---

## 1. `digitSum` → `euler.math`

### Source
`pe-0119/source/app.d`:
```d
private int digitSum(long n) pure nothrow @nogc {
    int s = 0;
    while (n > 0) { s += cast(int)(n % 10); n /= 10; }
    return s;
}
```

### Proposed signature

```d
T digitSum(T)(T n) pure nothrow @nogc if (isIntegral!T) {
    return digitReduce!(d => d)(n);
}
```

### Generic?
Yes. The existing copy uses `int`/`long` types only because the problem happens to
involve `long` inputs; `digitSum(42u)` is equally valid.

### Migration — 1 file

| File | Change |
|------|--------|
| pe-0119 | Remove `digitSum`; add `import euler.math : digitSum` inside `solve()` |

### Assessment
Straightforward. `digitSum` is as fundamental as `digitFactSum` (already in the
library). The `digitReduce` building block is the primary addition; `digitSum` and
`digitSquareSum` are the natural first wrappers.

---

## 2. `digitSquareSum` → `euler.math`

### Source
`pe-0092/source/app.d`:
```d
private int digitSquareSum(int n) pure nothrow @nogc {
    int s = 0;
    while (n > 0) { int d = n % 10; s += d * d; n /= 10; }
    return s;
}
```

### Proposed signature

```d
T digitSquareSum(T)(T n) pure nothrow @nogc if (isIntegral!T) {
    return digitReduce!(d => d * d)(n);
}
```

### Generic?
Yes. Same reasoning as `digitSum`.

### Migration — 1 file

| File | Change |
|------|--------|
| pe-0092 | Remove `digitSquareSum`; add `import euler.math : digitSquareSum` inside `solve()`. Note: pe-0092 calls `digitSquareSum` on `int` inputs but the chain reduction values stay small, so `T = int` template instantiation is identical to the existing function. |

### Assessment
Straightforward — same as `digitSum`. The `digitReduce` refactor of `digitFactSum`
happens at the same time (library-only, no callers to update).

---

## 3. `isTriangle` / `tri` → `euler.math`

### Source
`pe-0042/source/app.d`:
```d
private bool isTriangle(int n) pure nothrow @nogc {
    import euler.math : isPerfectSquare;
    return isPerfectSquare(1 + 8 * n);
}
```
(`tri` is absent from pe-0042; the generator is added as a bonus, matching the
`pent`/`isPent` precedent.)

### Proposed signatures

```d
// Generator: T(n) = n*(n+1)/2
T tri(T)(T n) pure nothrow @nogc if (isIntegral!T) {
    Unqual!T m = cast(Unqual!T)n;
    return m * (m + 1) / 2;
}

// Predicate: 1 + 8*n must be a perfect square.
bool isTriangle(T)(T n) if (isIntegral!T) {
    return isPerfectSquare(1 + 8 * cast(Unqual!T)n);
}
```

`isTriangle` is not `pure nothrow @nogc` because `isPerfectSquare` uses
`std.math.sqrt` and does not carry those attributes.

### Generic?
Yes. Same pattern as `isPent(T)`.

### Migration — 1 file

| File | Change |
|------|--------|
| pe-0042 | Remove local `isTriangle`; add `import euler.math : isTriangle` inside `solve()` |

### Assessment
Direct parallel to the `isPent/pent` Tier 1 promotion. Adds a third figurate-number
pair to the library (`tri/isTriangle`, `pent/isPent`, and eventually `hex/isHex`).
Zero behaviour change.

---

## 4. `digitMask` → `euler.math` (conditional)

### Source
`pe-0032/source/app.d`:
```d
// Returns a bitmask with bit d set for each digit d of n (d = 1-9).
// Returns 0 if any digit is 0 or appears more than once.
private uint digitMask(int n) pure nothrow @nogc { … }
```

### Proposed signature

```d
// Bitmask of digits 1–9 present in n; returns 0 if any digit is 0 or repeated.
uint digitMask(T)(T n) pure nothrow @nogc if (isIntegral!T) {
    uint mask = 0;
    Unqual!T m = cast(Unqual!T)n;
    while (m > 0) {
        immutable d = cast(int)(m % 10);
        if (d == 0 || (mask >> d) & 1) return 0;
        mask |= 1u << d;
        m /= 10;
    }
    return mask;
}
```

### Generic?
Yes, trivially. The body only uses integer arithmetic on individual digits.

### Migration — 1 file

| File | Change |
|------|--------|
| pe-0032 | Remove `digitMask`; add `import euler.math : digitMask` inside `solve()` |

### Assessment
**Conditional.** The function is clean and `pure nothrow @nogc`, but pe-0032 is its
only current consumer. The pandigital-product check pattern (`digitMask(a) +
digitMask(b) + digitMask(c) == 0x3FEu`) is a recurring PE idiom (problems 32, 38,
41, etc.) — those other files use ad-hoc approaches today, so the library version is
not currently preventing duplication. **Recommendation: promote when a second caller
appears; leave local for now.**

---

## 5. `omegaSieve` → `euler.math`

### Source
`pe-0047/source/app.d`:
```d
private ulong[] generateOmegaSieve(ulong limit) {
    ulong[] omegaSieve = new ulong[](limit);
    for (ulong i = 2; i < limit; i++)
        if (omegaSieve[i] == 0)
            for (ulong j = i; j < limit; j += i)
                omegaSieve[j]++;
    return omegaSieve;
}
```

### Proposed signature

```d
// ω(n) sieve: result[i] = count of distinct prime factors of i, for i in [0, limit).
// Analogous to sieve(n); result type uint (max ω(n) ≤ 15 for any 64-bit n).
uint[] omegaSieve(T)(T limit) if (isIntegral!T) {
    auto result = new uint[](cast(size_t)limit);
    for (size_t i = 2; i < cast(size_t)limit; ++i)
        if (result[i] == 0)
            for (size_t j = i; j < cast(size_t)limit; j += i)
                ++result[j];
    return result;
}
```

Changes from the local version:
- Renamed `generateOmegaSieve` → `omegaSieve` (matches `sieve`/`segmentedSieve` naming).
- Return type `ulong[]` → `uint[]` (ω(n) ≤ 15 for all 64-bit n; halves memory).
- Index type `ulong` → `size_t` (correct for array indexing on both 32/64-bit).

### Generic?
Yes — `limit` parameter generalised so callers can pass `int`, `uint`, or `ulong`
without casting.

### Migration — 1 file

| File | Change |
|------|--------|
| pe-0047 | Remove `generateOmegaSieve`; add `import euler.math : omegaSieve` inside `solve()`. Update loop: `omegaSieve[i + j] != requiredFactors` → still valid; `ulong` comparisons become `uint` comparisons, no cast needed. |

### Assessment
Natural companion to `sieve` and `segmentedSieve`. The rename and type fix are
improvements that benefit future callers. Medium effort: one file, one rename, and a
minor type-compatibility check at the call site.

---

## 6. `cfPeriod` → `euler.math`

### Source
`pe-0064/source/app.d`:
```d
// Returns the CF period length of √n, or 0 for perfect squares.
private uint cfPeriod(int n) pure nothrow @nogc {
    import std.math : sqrt;
    immutable int a0 = cast(int) sqrt(cast(double) n);
    if (a0 * a0 == n) return 0;
    int m = 0, d = 1, a = a0;
    uint period = 0;
    do { … } while (a != 2 * a0);
    return period;
}
```

### Proposed signature

```d
// Length of the continued-fraction period of √n; 0 if n is a perfect square.
// Precision note: uses real (80-bit) sqrt for the initial approximation to handle
// large T without losing the integer part.
uint cfPeriod(T)(T n) pure nothrow @nogc if (isIntegral!T) {
    import std.math : sqrt;
    immutable Unqual!T a0 = cast(Unqual!T)sqrt(cast(real)n);
    if (a0 * a0 == n) return 0;
    Unqual!T m = 0, d = 1, a = a0;
    uint period = 0;
    do {
        m = d * a - m;
        d = (n - m * m) / d;
        a = (a0 + m) / d;
        ++period;
    } while (a != 2 * a0);
    return period;
}
```

Improvement over the local copy: `cast(double)` → `cast(real)` for the initial sqrt,
making it correct for large `T` values where a 53-bit mantissa would lose the integer
part.

### Generic?
Yes. The algorithm is purely integer arithmetic after the initial sqrt; `Unqual!T`
throughout.

### Migration — 1 file

| File | Change |
|------|--------|
| pe-0064 | Remove `cfPeriod`; add `import euler.math : cfPeriod` inside `solve()` |

### Assessment
`cfPeriod` underpins both pe-0064 and pe-0066 (pe-0066 embeds the same CF loop
inside `pellMinX`). Promoting `cfPeriod` doesn't directly simplify pe-0066's
`pellMinX`, because `pellMinX` needs the convergents themselves, not just the period
length. Nevertheless `cfPeriod` is a standard algorithm worth having in the library
for future problems involving continued fractions.

---

## 7. `pellMinX` → `euler.math`

### Source
`pe-0066/source/app.d`:
```d
private BigInt pellMinX(int D) {
    import std.math : sqrt;
    immutable int a0 = cast(int) sqrt(cast(double) D);
    int m = 0, d = 1, a = a0;
    BigInt h2 = BigInt(1), h1 = BigInt(a0);
    BigInt k2 = BigInt(0), k1 = BigInt(1);
    for (;;) {
        m = d * a - m;
        d = (D - m * m) / d;
        a = (a0 + m) / d;
        BigInt h = BigInt(a) * h1 + h2;
        BigInt k = BigInt(a) * k1 + k2;
        if (h * h - k * k * D == 1) return h;
        h2 = h1; h1 = h; k2 = k1; k1 = k;
    }
}
```

### Proposed signature

```d
// Minimal positive x satisfying x² − D·y² = 1 (Pell equation).
// D must be a non-square positive integer; result requires BigInt (x grows fast).
BigInt pellMinX(int D) {
    import std.math : sqrt;
    immutable int a0 = cast(int) sqrt(cast(real) D);
    // … identical body, with cast(real) instead of cast(double) …
}
```

### Generic?
No. The Pell equation is inherently over integers and the convergent numerator
requires `BigInt` for any non-trivial D. Making `D` generic adds only noise: `long`
D values are not meaningful PE inputs, and `BigInt D` would require a completely
different implementation.

### Migration — 1 file

| File | Change |
|------|--------|
| pe-0066 | Remove `pellMinX`; add `import euler.math : pellMinX` (module-level, because `BigInt` appears in the call expression). No signature change needed at the call site. |

### Note on module-level import
`pellMinX` returns `BigInt`, and pe-0066 already has `import std.bigint : BigInt` at
module scope. Adding `import euler.math : pellMinX` to the module-level import block
follows the convention: `BigInt` in the return value of a library function means the
caller must have `BigInt` in scope.

### Assessment
Single caller today. Value is **discoverability**: the next time a PE problem
requires the minimal solution of a Pell equation, the library has it. Low effort,
low risk.

---

## 8. `partitions` → `euler.math`

### Source
`pe-0076/source/app.d`:
```d
private size_t computePartitions(int n) {
    auto partitions = new size_t[n + 1];
    partitions[0] = 1;
    foreach (i; 1 .. n + 1)
        foreach (j; i .. n + 1)
            partitions[j] += partitions[j - i];
    return partitions[n];
}
```

### Proposed signature

```d
// Number of integer partitions of n (unrestricted; includes n itself).
// p(n) grows super-exponentially: p(200) ≈ 3.97×10¹², so ulong is used throughout.
ulong partitions(T)(T n) if (isIntegral!T) {
    auto p = new ulong[](cast(size_t)n + 1);
    p[0] = 1;
    foreach (i; 1 .. cast(size_t)n + 1)
        foreach (j; i .. cast(size_t)n + 1)
            p[j] += p[j - i];
    return p[cast(size_t)n];
}
```

Changes from the local version:
- Renamed `computePartitions` → `partitions` (cleaner; matches `sieve` naming style).
- Return type `size_t` → `ulong` (size_t is 32-bit on 32-bit targets; p(200) > 2³²).
- Template over `T` so callers can pass `int`, `uint`, etc.

### Generic?
Yes — trivially, same as `omegaSieve`.

### Migration — 1 file

| File | Change |
|------|--------|
| pe-0076 | Remove `computePartitions`; add `import euler.math : partitions` inside `solve()`. Call site: `partitions(100) - 1` (the `-1` subtracts the trivial partition `100 = 100` per the problem statement — this stays at the call site, not in the library function). |

### Assessment
Standard combinatorics function with multiple PE appearances (76, 78, 31). pe-0031
(coin sums) uses a similar but distinct DP; pe-0078 (partition divisibility) would
directly reuse `partitions`. Medium-value promotion.

---

## 9. `kadane` → `euler.math` (conditional)

### Source
`pe-0149/source/app.d`:
```d
private long kadane(const int[] a) pure nothrow @nogc {
    import std.algorithm.comparison : max;
    long best = a[0], cur = a[0];
    foreach (x; a[1 .. $]) {
        cur = max(cast(long) x, cur + x);
        best = max(best, cur);
    }
    return best;
}
```

### Proposed signature

```d
// Maximum subarray sum (Kadane's algorithm). Returns long to avoid overflow
// when element type is int and the array is large.
long kadane(T)(const T[] a) pure nothrow @nogc if (isIntegral!T) {
    import std.algorithm.comparison : max;
    long best = a[0], cur = a[0];
    foreach (x; a[1 .. $]) {
        cur = max(cast(long)x, cur + x);
        best = max(best, cur);
    }
    return best;
}
```

### Generic?
Marginally. `T = int` is the only realistic PE use case; fixing the return to `long`
handles overflow regardless.

### Migration — 1 file

| File | Change |
|------|--------|
| pe-0149 | Remove `kadane`; add `import euler.math : kadane` inside `solve()` |

### Assessment
**Conditional.** The function is correct, `pure nothrow @nogc`, and a well-known
algorithm — but pe-0149 is its only consumer. Signature and proposed library form
are documented above; promotion deferred until a second PE problem requires it.

---

## Summary

| Candidate | Decision | Generic? | Files touched | Status |
|-----------|----------|----------|---------------|--------|
| `digitReduce` (new building block) | Promote → `euler.math` | Yes, `alias f + T` | library only | Done (64287d2) |
| `digitSum` | Promote → `euler.math` | Yes, `T` | pe-0119 + library | Done (64287d2) |
| `digitSquareSum` | Promote → `euler.math` | Yes, `T` | pe-0092 + library | Done (64287d2) |
| `digitFactSum` (internal refactor) | Refactor body via `digitReduce` | Yes, `T` | library only (no API change) | Done (64287d2) |
| `isTriangle` / `tri` | Promote → `euler.math` | Yes, `T` | pe-0042 + library | Done (c2ba820) |
| `omegaSieve` | Promote → `euler.math` | Yes, `T` | pe-0047 + library | Done (3bf8ead) |
| `cfPeriod` | Promote → `euler.math` | Yes, `T` | pe-0064 + library | Done (e1f0cc7) |
| `pellMinX` | Promote → `euler.math` | No (`BigInt` only) | pe-0066 + library | Done (37621ab) |
| `partitions` | Promote → `euler.math` | Yes, `T` | pe-0076 + library | Done (b58ca6a) |
| `digitMask` | Leave local (single user) | Yes, `T` | — | Not promoted |
| `kadane` | Deferred — promote when second caller appears | Yes, `T` | pe-0149 + library | Pending |

**Net library additions:** 9 new public symbols (`digitReduce`, `digitSum`,
`digitSquareSum`, `tri`, `isTriangle`, `omegaSieve`, `cfPeriod`, `pellMinX`,
`partitions`) + 1 rename (`computePartitions` → `partitions`) + 1 internal refactor
(`digitFactSum` body via `digitReduce`).

**Still local:** `digitMask` (pe-0032) and `kadane` (pe-0149) — both single-user;
`kadane` signature is documented above and ready to promote when a second caller
appears.

**Migration effort:** 6 app.d files updated (pe-0042, pe-0047, pe-0064, pe-0066,
pe-0076, pe-0092, pe-0119 — 7 total including digitSum/digitSquareSum as two separate
files), no behaviour change in any.
