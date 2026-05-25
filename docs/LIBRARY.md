# Shared library (`pe-common`)

### `euler.common`

| Symbol | Description |
|--------|-------------|
| `runSolution!(solver)(N)` | Starts a timer, calls `solver()`, prints the answer and elapsed time |

### `euler.math`

| Symbol | Description |
|--------|-------------|
| `countDivisors(n)` | Number of divisors via prime factorisation — O(√n), any integral type |
| `isPrime(n)` | Primality test — trial division for n ≤ 1 000 000; deterministic Miller-Rabin (9 witnesses {2..23}, covers full `long` range) above that bound — any integral type |
| `mulmod(a, b, m)` | Overflow-safe `(a × b) mod m` for arbitrary `long` values — x86-64 hardware 128-bit path; Russian-peasant binary fallback elsewhere |
| `largestPrimeFactor(n)` | Largest prime factor of `n` |
| `nthPrime!T(n)` | Returns the nth prime as type `T` (default `int`), sized by Rosser's bound |
| `sieve(n)` | Sieve of Eratosthenes — returns `bool[0..n]`, O(n log log n) |
| `segmentedSieve(lo, hi)` | Range sieve — returns `bool[]` where `result[i]` is true iff `lo+i` is prime; O(hi-lo + √hi) memory |
| `omegaSieve(limit)` | ω(n) sieve — returns `uint[]` where `result[i]` = number of distinct prime factors of `i`, for `i` in `[0, limit)` — any integral type |
| `reverseDigits(n)` | Reverses the decimal digits of an integer |
| `isPalindrome(n)` | Returns `true` if `n == reverseDigits(n)` |
| `digitFreq(n)` | Digit-frequency fingerprint as a `ulong` (nibble per digit 0–9); `digitFreq(a) == digitFreq(b)` iff `a` and `b` are digit permutations of each other — any integral type |
| `digitReduce!(f)(n)` | Applies compile-time alias `f` to each decimal digit of `n` and sums the results — building block for digit-transform functions; any integral type |
| `digitSum(n)` | Sum of the decimal digits of `n` — any integral type |
| `digitSquareSum(n)` | Sum of the squares of the decimal digits of `n` — any integral type |
| `digitFactSum(n)` | Sum of the factorials of the decimal digits of `n` — any integral type |
| `isPerfectSquare(n)` | `true` if `n` is a perfect square — any integral type |
| `pent(n)` | Pentagonal number generator — P(n) = n(3n−1)/2 — any integral type |
| `isPent(n)` | `true` if `n` is a pentagonal number — any integral type |
| `tri(n)` | Triangular number generator — T(n) = n(n+1)/2 — any integral type |
| `isTriangle(n)` | `true` if `n` is a triangular number — any integral type |
| `mod(a, b)` | True modulo — always non-negative, unlike D's `%` remainder |
| `binomial(n, k)` | Binomial coefficient C(n, k); 0 for k < 0 or k > n; result fits in `long` for n ≤ 66 |
| `partitions(n)` | Number of integer partitions of `n` (includes the trivial partition); returns `ulong` — any integral type |
| `cfPeriod(n)` | Length of the continued-fraction period of √n; returns 0 if `n` is a perfect square — any integral type |
| `pellMinX(D)` | Minimal positive `x` satisfying x²−D·y²=1 (Pell equation), via CF convergents of √D; returns `BigInt` |
| `fib!T(n)` | nth Fibonacci number as type `T` (default `BigInt`); use `fib!long(n)` for n ≤ 93 |
| `fibFirstNDigits(d)` | Index of the first Fibonacci number with at least `d` decimal digits — Binet's formula, 80-bit real |
| `matMul(A, B, modulus)` | 2×2 matrix multiplication mod `modulus` |
| `matVecMul(M, v, modulus)` | 2×2 matrix × 2-vector multiplication mod `modulus` |
| `matPow(M, n, modulus)` | 2×2 matrix power `M^n` mod `modulus`; `n` may be any integral type or `BigInt` |

### `euler.rat`

| Symbol | Description |
|--------|-------------|
| `Rat(n, d)` | Exact rational `n/d` — GCD-reduced, denominator always positive; `long`-backed |
| `+  -  *  /` | Arithmetic operators; `/` asserts divisor is non-zero |
| `==  <  <=  >  >=` | Comparison via `opEquals` / `opCmp` |
| `isInteger()` | `true` if denominator is 1 after reduction |
| `toDouble()` | Floating-point approximation |
| `toString()` | `"n"` when integer, `"n/d"` otherwise |

### `euler.numerics`

| Symbol | Description |
|--------|-------------|
| `Method` | Enum selecting the algorithm: `NewtonRaphson`, `Brent`, `Toms748`, `Itp` |
| `label(m)` | Returns a human-readable name for a `Method` value |
| `SolveResult` | Result struct — `method` (Method), `root` (double), `evals` (size_t) |
| `Solver(method, a, b, func)` | Configures a root-finding solve for f(r) = 0 on \[a, b\]; `func` is a `double delegate(double)` |
| `Solver.solve()` | Runs the selected algorithm and returns a `SolveResult` |
