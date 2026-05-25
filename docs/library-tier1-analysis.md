# Tier 1 Library Candidates — Decision Document

Analysis of the four confirmed duplicates from the 2026-05-25 library audit.
Each entry covers: proposed signature, genericity rationale, migration effort, and recommendation.

---

## 1. `isPent` / `pent` → `euler.math`

### Proposed signatures

```d
// Generator
T pent(T)(T n) if (isIntegral!T) { return n * (3 * cast(Unqual!T)n - 1) / 2; }

// Predicate — mirrors isPerfectSquare's pattern exactly
bool isPent(T)(T n) if (isIntegral!T) {
    import std.math : sqrt;
    Unqual!T d  = 24 * cast(Unqual!T)n + 1;
    Unqual!T s  = cast(Unqual!T)sqrt(cast(real)d);
    if (      s  * s  == d) return (s  + 1) % 6 == 0;
    Unqual!T s1 = s + 1;
    return s1 * s1 == d && (s1 + 1) % 6 == 0;
}
```

### Generic?
Yes — same pattern as the existing `isPerfectSquare(T)`. `Unqual!T` required throughout
(mutable working vars in templates; see feedback rule). Overflow risk for `isPent`: `24n+1`
overflows `long` only when n > 7.6×10¹⁷, irrelevant for PE.

### Migration — 2 files

| File | Change |
|------|--------|
| pe-0044 | Remove `pent`, `isPent`; add `import euler.math : pent, isPent` inside `solve()` |
| pe-0045 | Remove `isPent`; add `import euler.math : isPent` inside `solve()` |

### Assessment
Straightforward. Zero behaviour change. `pent` is a bonus — adds the generator
alongside the predicate, matching the pattern of other figurate-number utilities.

---

## 2. `digitFactSum` → `euler.math`

### Proposed signature

```d
T digitFactSum(T)(T n) if (isIntegral!T) {
    static immutable int[10] fact = [1,1,2,6,24,120,720,5_040,40_320,362_880];
    Unqual!T s = 0;
    Unqual!T m = cast(Unqual!T)n;
    while (m > 0) { s += fact[m % 10]; m /= 10; }
    return s;
}
```

### Generic?
Yes. The lookup values all fit in `int` regardless of T (max is 9! = 362 880);
`Unqual!T` for the accumulator. `static immutable` keeps the table in the library
rather than duplicated at each call site.

### Migration — 2 files

| File | Change |
|------|--------|
| pe-0034 | Remove module-level `fact` array and `digitFactSum`; add `import euler.math : digitFactSum` inside `solve()`. The module-level `limit` constant (`7u * 362_880u`) stays — it is problem-specific. |
| pe-0074 | Remove `digitFactSum` (its table is already `static immutable` inside the function body); add `import euler.math : digitFactSum` inside `solve()` |

### Assessment
Straightforward. pe-0034's `uint` path and pe-0074's `int` path are both handled
by the single template instantiation.

---

## 3. `mulmod` (public) + `isPrime` range upgrade → `euler.math`

Highest-value change. The library's current `isPrime` falls back to O(√n) trial
division for n ≥ 3.215×10⁹. pe-0146's implementation is deterministic for the
full `long` range using 9 witnesses.

### Proposed library changes

```d
// Public — overflow-safe a*b mod m for arbitrary long values.
// x86-64: hardware 128-bit MUL/DIV; other: Russian-peasant binary method.
long mulmod(long a, long b, long m) pure nothrow @nogc {
    a %= m;
    version (D_InlineAsm_X86_64) {
        long result = void;
        asm pure nothrow @nogc {
            mov RAX, a;
            mov RCX, m;
            mul b;       // RDX:RAX = a*b (unsigned 128-bit)
            div RCX;     // remainder → RDX
            mov result, RDX;
        }
        return result;
    } else {
        long res = 0;
        for (; b > 0; b >>= 1) {
            if (b & 1) { res += a; if (res >= m) res -= m; }
            a <<= 1; if (a >= m) a -= m;
        }
        return res;
    }
}

// Private helper — modular exponentiation via mulmod.
private long mulpow(long b, long e, long m) pure nothrow @nogc {
    long r = 1; b %= m;
    for (; e > 0; e >>= 1) {
        if (e & 1) r = mulmod(r, b, m);
        b = mulmod(b, b, m);
    }
    return r;
}

// Upgrade isPrimeMR: 9 witnesses {2..23}, deterministic for ALL long values
// (bound 3.317×10²⁴ >> long.max ≈ 9.2×10¹⁸). Replaces the old 4-witness version.
private bool isPrimeMR(long n) pure nothrow @nogc {
    long d = n - 1; int r = 0;
    while (!(d & 1)) { d >>= 1; ++r; }
    static immutable long[9] w = [2,3,5,7,11,13,17,19,23];
    foreach (a; w) {
        if (n == a) return true;
        if (n % a == 0) return false;
        long x = mulpow(a, d, n);
        if (x == 1 || x == n - 1) continue;
        bool composite = true;
        foreach (_; 1 .. r) {
            x = mulmod(x, x, n);
            if (x == n - 1) { composite = false; break; }
        }
        if (composite) return false;
    }
    return true;
}

// isPrime: trial div ≤ 1M, 9-witness MR for everything above.
// Removes the old trial-division fallback for n ≥ 3.215×10⁹.
bool isPrime(T)(T n) if (isIntegral!T) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    if (n > 1_000_000) return isPrimeMR(cast(long)n);
    Unqual!T i = 5;
    while (i * i <= n) {
        if (n % i == 0 || n % (i + 2) == 0) return false;
        i += 6;
    }
    return true;
}
```

### Note on `asm pure nothrow @nogc`
D permits these attributes on inline asm blocks when the programmer guarantees them.
Both code paths (arithmetic only, no allocation, no exceptions) qualify.

### Migration — 2 files + library

| File | Change |
|------|--------|
| pe-0111 | Remove `mulmod`, `modpow`, `isPrime10`; replace every `isPrime10(n)` call with `isPrime!long(n)` (imported from `euler.math`) inside `solve()` |
| pe-0146 | Remove `mulmod`, `powmod`, `millerRabin`, local `isPrime`; add `import euler.math : isPrime` inside `solve()` |
| `euler.math` | Add public `mulmod`, private `mulpow`, replace `isPrimeMR` (new signature `long` instead of `ulong`, 9 witnesses), simplify `isPrime` threshold; update unittest to cover large-n path |

### Side effect (positive)
Every existing solution that was silently using slow O(√n) trial division for large
primes (pe-0132, pe-0133, pe-0128, …) automatically gets fast O(log²n) Miller-Rabin.
No API change, no callers to update beyond the two above.

### Risk
`asm pure` requires the programmer to guarantee correctness. The arithmetic is sound,
but this is the only non-trivial claim in the entire tier-1 set.

---

## 4. `isSpecial` — do NOT promote

The function is specific to the PE "special subset sum" problem family (103, 105;
106 bypasses it via combinatorics). The name is opaque outside that narrow context
and the algorithm does not generalise beyond it.

**Recommendation: local harmonisation only.**

pe-0103 uses a fixed-size `ref int[7]` signature and a hardcoded `1..4` loop bound;
pe-0105 uses the general `int[]` form with `1..(n-1)/2+1`. Update pe-0103 to match:

| File | Change |
|------|--------|
| pe-0103 | `isSpecial(ref int[7] a)` → `isSpecial(int[] a)`; generalise body to use `a.length`; call site: `isSpecial(a[])` |

This removes the duplication without polluting the library with domain-specific logic.

---

## Summary

| Candidate | Decision | Generic? | Files touched |
|-----------|----------|----------|---------------|
| `isPent` / `pent` | Promote → `euler.math` | Yes, `T` | pe-0044, pe-0045 |
| `digitFactSum` | Promote → `euler.math` | Yes, `T` | pe-0034, pe-0074 |
| `mulmod` + `isPrime` upgrade | Promote → `euler.math` | No (`long` only) | pe-0111, pe-0146 + library |
| `isSpecial` | Local harmonisation only | — | pe-0103 |
