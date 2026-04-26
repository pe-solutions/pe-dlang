# Dlang Project Euler solutions

<p align="center"><img src="logo.png"></p>

I followed the ins and outs of [DMD](https://dlang.org/) since early 2004 when the _"Great Divide"_ Phobos/Tango debate was still prevalent.

I ❤️ D!

---

## Structure

```
pe-dlang/
├── pe-common/          # Shared library
│   └── source/euler/
│       ├── common.d    # runSolution template
│       └── math.d      # isPrime, sieve, reverseDigits, isPalindrome,
│                       # largestPrimeFactor, mod
├── pe-XXXX/            # One DUB package per problem
│   ├── dub.json
│   └── source/app.d
└── build-all.ps1       # Build all solutions in one shot
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
| `reverseDigits(n)` | Reverses the decimal digits of an integer |
| `isPalindrome(n)` | Returns `true` if `n == reverseDigits(n)` |
| `largestPrimeFactor(n)` | Returns the largest prime factor of `n` |
| `mod(a, b)` | True modulo — always non-negative, unlike D's `%` remainder |

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

| # | Title |
|---|-------|
| [1](../pe-0001/source/app.d) | Multiples of 3 or 5 |
| [2](../pe-0002/source/app.d) | Even Fibonacci Numbers |
| [3](../pe-0003/source/app.d) | Largest Prime Factor |
| [4](../pe-0004/source/app.d) | Largest Palindrome Product |
| [5](../pe-0005/source/app.d) | Smallest Multiple |
| [6](../pe-0006/source/app.d) | Sum Square Difference |
| [7](../pe-0007/source/app.d) | 10001st Prime |
| [8](../pe-0008/source/app.d) | Largest Product in a Series |
| [9](../pe-0009/source/app.d) | Special Pythagorean Triplet |
| [10](../pe-0010/source/app.d) | Summation of Primes |
| [14](../pe-0014/source/app.d) | Longest Collatz Sequence |
| [15](../pe-0015/source/app.d) | Lattice Paths |
| [19](../pe-0019/source/app.d) | Counting Sundays |
| [20](../pe-0020/source/app.d) | Factorial Digit Sum |
| [28](../pe-0028/source/app.d) | Number Spiral Diagonals |
| [31](../pe-0031/source/app.d) | Coin Sums |
| [38](../pe-0038/source/app.d) | Pandigital Multiples |
| [39](../pe-0039/source/app.d) | Integer Right Triangles |
| [40](../pe-0040/source/app.d) | Champernowne's Constant |
| [47](../pe-0047/source/app.d) | Distinct Primes Factors |
| [48](../pe-0048/source/app.d) | Self Powers |
| [49](../pe-0049/source/app.d) | Prime Permutations |
| [50](../pe-0050/source/app.d) | Consecutive Prime Sum |
| [55](../pe-0055/source/app.d) | Lychrel Numbers |
| [56](../pe-0056/source/app.d) | Powerful Digit Sum |
| [60](../pe-0060/source/app.d) | Prime Pair Sets |
| [63](../pe-0063/source/app.d) | Powerful Digit Counts |
| [76](../pe-0076/source/app.d) | Counting Summations |
| [91](../pe-0091/source/app.d) | Right Triangles with Integer Coordinates |
| [97](../pe-0097/source/app.d) | Large Non-Mersenne Prime |
| [206](../pe-0206/source/app.d) | Concealed Square |
| [345](../pe-0345/source/app.d) | Matrix Sum |
| [455](../pe-0455/source/app.d) | Powers With Trailing Digits |
| [800](../pe-0800/source/app.d) | Hybrid Integers |
| [808](../pe-0808/source/app.d) | Reversible Prime Squares |
| [820](../pe-0820/source/app.d) | Nth Digit of Reciprocals |
| [849](../pe-0849/source/app.d) | The Tournament |
