# Shared library (`pe-common`)

### `euler.common`

| Symbol | Description |
|--------|-------------|
| `runSolution!(solver)(N)` | Starts a timer, calls `solver()`, prints the answer and elapsed time |

### `euler.math`

| Symbol | Description |
|--------|-------------|
| `countDivisors(n)` | Number of divisors via prime factorisation — O(√n), any integral type |
| `isPrime(n)` | Trial division primality test — O(√n), works on any integral type |
| `sieve(n)` | Sieve of Eratosthenes — returns `bool[0..n]`, O(n log log n) |
| `segmentedSieve(lo, hi)` | Range sieve — returns `bool[]` where `result[i]` is true iff `lo+i` is prime; O(hi-lo + √hi) memory |
| `nthPrime!T(n)` | Returns the nth prime as type `T` (default `int`), sized by Rosser's bound |
| `reverseDigits(n)` | Reverses the decimal digits of an integer |
| `isPalindrome(n)` | Returns `true` if `n == reverseDigits(n)` |
| `isPerfectSquare(n)` | `true` if `n` is a perfect square — any integral type |
| `largestPrimeFactor(n)` | Returns the largest prime factor of `n` |
| `mod(a, b)` | True modulo — always non-negative, unlike D's `%` remainder |
| `fib!T(n)` | nth Fibonacci number as type `T` (default `BigInt`); use `fib!long(n)` for n ≤ 93 |
| `matMul(A, B, modulus)` | 2×2 matrix multiplication mod `modulus` |
| `matVecMul(M, v, modulus)` | 2×2 matrix × 2-vector multiplication mod `modulus` |
| `matPow(M, n, modulus)` | 2×2 matrix power `M^n` mod `modulus`; `n` may be any integral type or `BigInt` |

### `euler.numerics`

| Symbol | Description |
|--------|-------------|
| `Method` | Enum selecting the algorithm: `NewtonRaphson`, `Brent`, `Toms748`, `Itp` |
| `label(m)` | Returns a human-readable name for a `Method` value |
| `SolveResult` | Result struct — `method` (Method), `root` (double), `evals` (size_t) |
| `Solver(method, a, b, func)` | Configures a root-finding solve for f(r) = 0 on \[a, b\]; `func` is a `double delegate(double)` |
| `Solver.solve()` | Runs the selected algorithm and returns a `SolveResult` |
