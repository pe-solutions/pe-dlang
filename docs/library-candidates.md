# pe-common Library Candidates

Audit of `pe-XXXX/source/app.d` files for helper code worth promoting to the shared library.
Conducted 2026-05-25 against 162 solutions (pe-0001 – pe-0150 + scattered higher problems).

---

## Tier 1 — Confirmed Duplicates (same logic in 2+ files)

### `isPent(long n) → bool`
- **Files**: pe-0044, pe-0045 — identical implementations
- **Logic**: n is pentagonal iff `24n+1` is a perfect square `s` and `(s+1) % 6 == 0`
- **Note**: pe-0044 also has a generator `pent(n) = n*(3n-1)/2`; promote both

### `digitFactSum(n)`
- **Files**: pe-0034 (`uint`), pe-0074 (`int`)
- **Logic**: sum of the factorials of each decimal digit
- **Note**: same algorithm, different integral types; templatise on `T`

### `mulmod(a, b, m)` + `powmod / modpow`
- **Files**: pe-0111, pe-0146
- **Logic**: Russian-peasant binary mulmod to avoid 128-bit overflow; wraps a modular exponentiation
- **Note**: pe-0146 is strictly superior — x86-64 inline-asm fast path (`MUL/DIV` 128-bit) with
  binary fallback, and its accompanying Miller-Rabin is deterministic up to ~3.825×10¹⁸
  (witnesses `{2,3,5,7,11,13,17,19,23}`). Unify on pe-0146's implementation.

### `isSpecial(a)`
- **Files**: pe-0103 (`ref int[7]`), pe-0105 (`int[]`)
- **Logic**: special subset sum test — all non-empty subset sums distinct, and for any two
  disjoint non-empty subsets B, C with |B| > |C|, sum(B) > sum(C)
- **Note**: pe-0105's slice signature is the general form

---

## Tier 2 — Single-use, clearly general-purpose

### `kadane(const int[] a) → long`
- **File**: pe-0149
- **Logic**: O(n) Kadane algorithm for maximum contiguous subarray sum
- **Why**: textbook algorithm; likely to recur in future sequence optimisation problems

### `generateOmegaSieve(limit) → ulong[]`
- **File**: pe-0047
- **Logic**: sieve returning Ω(n) — count of distinct prime factors of each n up to `limit`
- **Why**: natural companion to the existing `sieve`; useful for divisibility and factorisation problems

### `computePartitions(int n) → size_t`
- **File**: pe-0076
- **Logic**: integer partition count via DP (coin-change recurrence over all positive integers)
- **Why**: fundamental combinatorial function; `p(n)` appears in multiple PE problems

### `cfPeriod(int n) → uint`
- **File**: pe-0064
- **Logic**: period length of the continued-fraction expansion of √n
- **Why**: Pell-equation problems lean on CF periods; likely to recur alongside `pellMinX`

### `pellMinX(int D) → BigInt`
- **File**: pe-0066
- **Logic**: minimum positive x solving x² − Dy² = 1 via CF convergents of √D
- **Why**: Pell equations appear in many PE problems; pairs with `cfPeriod`

### `digitSum(long n) → int`
- **File**: pe-0119
- **Logic**: sum of decimal digits
- **Why**: missing from the library despite being one of the most common digit operations

### `digitSquareSum(int n) → int`
- **File**: pe-0092
- **Logic**: sum of squares of decimal digits
- **Why**: same gap; natural sibling of `digitSum`

### `digitMask(int n) → uint`
- **File**: pe-0032
- **Logic**: pandigital bitmask — one bit per digit 1–9; returns 0 if digit 0 present or any digit repeats
- **Why**: already used implicitly across pe-0032, pe-0038, pe-0041, pe-0118; centralising would
  clean up several solutions

### `isTriangle(int n) → bool`
- **File**: pe-0042
- **Logic**: n is triangular iff `8n+1` is a perfect square
- **Why**: direct sibling to `isPent`; together they cover the most common figurate-number predicates

---

## Tier 3 — Lower priority / enhancement

| Item | File | Notes |
|------|------|-------|
| Extend `isPrime` upper bound | pe-0146 | Library tops out at ~3.2B (witnesses `{2,3,5,7}`); pe-0146 reaches ~3.825×10¹⁸ (9 witnesses). Upgrade in-place rather than adding a new symbol. |
| `isqrt(BigInt n) → BigInt` | pe-0080 | Newton's-method integer sqrt for `BigInt`; no `BigInt` sqrt in the library currently. |
| `rotate(int n, int pow10) → int` | pe-0035 | Circular digit rotation; niche but clean. |
| `isPandigital9(long n) → bool` | pe-0104 | 1–9 pandigital test; more specific than `digitMask` but covers a common PE pattern. |
