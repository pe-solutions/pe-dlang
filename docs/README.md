# Dlang Project Euler solutions

<p align="center"><img src="logo.png"></p>

I followed the ins and outs of [DMD](https://dlang.org/) since early 2004 when the _"Great Divide"_ Phobos/Tango debate was still prevalent.

I ❤️ D!

<p align="center">
  <a href="https://projecteuler.net/profile/mavotroky.png">
    <img src="https://projecteuler.net/profile/mavotroky.png" alt="Project Euler profile badge for mavotroky">
  </a>
</p>

---

## Structure

```
pe-dlang/
├── pe-common/          # Shared library
│   └── source/euler/
│       ├── common.d    # runSolution template
│       └── math.d      # isPrime, sieve, nthPrime, reverseDigits, isPalindrome,
│                       # largestPrimeFactor, mod, fib, matMul, matVec, matPow
├── pe-XXXX/            # One DUB package per problem
│   ├── dub.json
│   └── source/app.d
├── build-all.ps1       # Build all solutions in one shot
├── run-all.ps1         # Run all solutions in one shot
└── clean-all.ps1       # Clean all solutions in one shot
```

Each `pe-XXXX/` directory is a self-contained [DUB](https://dub.pm/) package that depends on `pe-common` via a local path.

---

## Building

**Single solution** — run from inside the problem directory:

```powershell
cd pe-0001
dub run
dub run --build=release   # optimised
```

**All solutions at once** — run from the repo root:

```powershell
.\build-all.ps1                  # debug build
.\build-all.ps1 -Release         # release build
.\build-all.ps1 -ShowOutput      # print dub output for every solution
```

**Run all solutions at once:**

```powershell
.\run-all.ps1                    # debug build + run
.\run-all.ps1 -Release           # release build + run
.\run-all.ps1 -ShowOutput        # also print dub build messages on success
```

**Clean all solutions at once:**

```powershell
.\clean-all.ps1                  # remove build artifacts
.\clean-all.ps1 -ShowOutput      # print dub output for every solution
```

---

## Shared library (`pe-common`)

### `euler.common`

| Symbol | Description |
|--------|-------------|
| `runSolution!(solver, N)()` | Starts a timer, calls `solver()`, prints the answer and elapsed time |

### `euler.math`

| Symbol | Description |
|--------|-------------|
| `isPrime(n)` | Trial division primality test — O(√n), works on any integral type |
| `sieve(n)` | Sieve of Eratosthenes — returns `bool[0..n]`, O(n log log n) |
| `nthPrime!T(n)` | Returns the nth prime as type `T` (default `int`), sized by Rosser's bound |
| `reverseDigits(n)` | Reverses the decimal digits of an integer |
| `isPalindrome(n)` | Returns `true` if `n == reverseDigits(n)` |
| `largestPrimeFactor(n)` | Returns the largest prime factor of `n` |
| `mod(a, b)` | True modulo — always non-negative, unlike D's `%` remainder |
| `fib!T(n)` | nth Fibonacci number as type `T` (default `BigInt`); use `fib!long(n)` for n ≤ 93 |
| `matMul(A, B, m)` | 2×2 matrix multiplication mod `m` |
| `matVec(M, v, m)` | 2×2 matrix × 2-vector multiplication mod `m` |
| `matPow(M, n, m)` | 2×2 matrix power `M^n` mod `m`; `n` may be any integral type or `BigInt` |

---

## Solution conventions

Every `app.d` follows the same pattern:

```d
// Problem title
// https://projecteuler.net/problem=N

import ...;
import euler.math : ...;       // math utilities as needed
import euler.common : runSolution;

// helper functions if any

auto solve() {
    // ...
    return answer;
}

void main() { runSolution!(solve, N)(); }
```

`runSolution` handles the timer and output format:

```
Project Euler #N
Answer: 12345
Elapsed time: 3 milliseconds.
```

---

## Solutions

| # | Title | Approach |
|---|-------|----------|
| [1](../pe-0001/source/app.d) | Multiples of 3 or 5 | Range filter and sum |
| [2](../pe-0002/source/app.d) | Even Fibonacci Numbers | Even-only recurrence E(n) = 4·E(n−1) + E(n−2), starting 2, 8 — skips all odd terms |
| [3](../pe-0003/source/app.d) | Largest Prime Factor | Trial-division factorisation |
| [4](../pe-0004/source/app.d) | Largest Palindrome Product | Cartesian product of 3-digit numbers, palindrome filter |
| [5](../pe-0005/source/app.d) | Smallest Multiple | LCM reduction over 1..20 |
| [6](../pe-0006/source/app.d) | Sum Square Difference | (Σn)² − Σ(n²) via range pipelines |
| [7](../pe-0007/source/app.d) | 10001st Prime | Sieve bounded by Rosser's theorem p_n < n(ln n + ln ln n) |
| [8](../pe-0008/source/app.d) | Largest Product in a Series | Sliding 13-digit window, maximise product |
| [9](../pe-0009/source/app.d) | Special Pythagorean Triplet | Nested search with a+b+c=1000, a²+b²=c² |
| [10](../pe-0010/source/app.d) | Summation of Primes | Trial division filter and sum below 2M |
| [14](../pe-0014/source/app.d) | Longest Collatz Sequence | Memoised iterative Collatz chain |
| [15](../pe-0015/source/app.d) | Lattice Paths | Combinatorics — C(2n, n) = C(40, 20) |
| [19](../pe-0019/source/app.d) | Counting Sundays | Date library — count first-of-month Sundays 1901–2000 |
| [20](../pe-0020/source/app.d) | Factorial Digit Sum | BigInt 100!, then digit sum |
| [28](../pe-0028/source/app.d) | Number Spiral Diagonals | Closed form: (4n³ + 3n² + 8n − 9) / 6 |
| [31](../pe-0031/source/app.d) | Coin Sums | Unbounded knapsack DP |
| [38](../pe-0038/source/app.d) | Pandigital Multiples | Search n × 100002; verify 9-digit pandigital |
| [39](../pe-0039/source/app.d) | Integer Right Triangles | Closed-form a = p(p−2b) / 2(p−b) eliminates inner loop |
| [40](../pe-0040/source/app.d) | Champernowne's Constant | Concatenate integers; index positions 10⁰..10⁶ and multiply |
| [47](../pe-0047/source/app.d) | Distinct Primes Factors | Omega sieve counts distinct prime factors; scan for 4 consecutive |
| [48](../pe-0048/source/app.d) | Self Powers | BigInt Σ(nⁿ), n=1..1000, mod 10¹⁰ |
| [49](../pe-0049/source/app.d) | Prime Permutations | Arithmetic progression step 3330 among digit-permutation primes |
| [50](../pe-0050/source/app.d) | Consecutive Prime Sum | Sliding sum of consecutive primes; track longest prime-valued sum |
| [55](../pe-0055/source/app.d) | Lychrel Numbers | Reverse-and-add up to 50 times; no palindrome ⇒ Lychrel |
| [56](../pe-0056/source/app.d) | Powerful Digit Sum | Maximise digit sum of aᵇ (BigInt) for a, b < 100 |
| [60](../pe-0060/source/app.d) | Prime Pair Sets | 5-clique in prime-pair graph: any two concatenate to a prime |
| [63](../pe-0063/source/app.d) | Powerful Digit Counts | dⁿ has n digits iff n ≤ ⌊1 / (1 − log₁₀ d)⌋; sum over d = 1..9 |
| [76](../pe-0076/source/app.d) | Counting Summations | Partition DP — p(100) − 1 |
| [91](../pe-0091/source/app.d) | Right Triangles with Integer Coordinates | Dot-product perpendicularity check on three vertex pairs |
| [97](../pe-0097/source/app.d) | Large Non-Mersenne Prime | Modular exponentiation: 28433·2^7830457 + 1 mod 10¹⁰ |
| [206](../pe-0206/source/app.d) | Concealed Square | sqrt bounds + alternating-digit pattern check, step 10 |
| [345](../pe-0345/source/app.d) | Matrix Sum | Bitmask DP — optimal column assignment over 15×15 matrix |
| [455](../pe-0455/source/app.d) | Powers With Trailing Digits | Fixed-point iteration k = nᵏ mod 10⁹ until stable |
| [800](../pe-0800/source/app.d) | Hybrid Integers | Log-space: q·log p + p·log q ≤ E·log B; binary search on q |
| [808](../pe-0808/source/app.d) | Reversible Prime Squares | Find primes p where both p² and rev(p²) are squares of primes |
| [820](../pe-0820/source/app.d) | Nth Digit of Reciprocals | nth digit of 1/k = (10ⁿ mod 10k) / k via modular exponentiation |
| [849](../pe-0849/source/app.d) | The Tournament | DP score distribution over 100 rounds, mod 10⁹+7 |
| [940](../pe-0940/source/app.d) | Two-Dimensional Recurrence | Matrix exponentiation on two coupled recurrences; sum A(f_i, f_j) over 2 ≤ i, j ≤ 50 with Fibonacci indices |
