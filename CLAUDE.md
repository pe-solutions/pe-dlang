# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

D language (DMD/DUB) solutions to [Project Euler](https://projecteuler.net/) problems. Each problem lives in its own isolated DUB package under `pe-XXXX/`. A shared library `pe-common` provides reusable math utilities and the solution runner.

## Structure

```
pe-dlang/
├── pe-common/          # Shared library
│   └── source/euler/
│       ├── common.d    # runSolution template
│       ├── math.d      # isPrime, sieve, nthPrime, reverseDigits,
│       │               # isPalindrome, largestPrimeFactor, mod,
│       │               # fib, matMul, matVecMul, matPow
│       └── numerics.d  # Solver, Method, SolveResult — root-finding
│                       # (Newton-Raphson, Brent-Dekker, TOMS 748, ITP)
├── pe-XXXX/            # One DUB package per problem
│   ├── dub.json
│   └── source/app.d
├── build-all.ps1       # Build all solutions in one shot
├── run-all.ps1         # Run all solutions in one shot
└── clean-all.ps1       # Clean all solutions in one shot
```

## Commands

**Single solution** — run from inside the problem directory:

```bash
dub build
dub run
dub run --build=release   # faster execution
```

**All solutions at once** — run from the repo root:

```powershell
.\build-all.ps1 [-Release] [-ShowOutput]
.\run-all.ps1   [-Release] [-ShowOutput]
.\clean-all.ps1 [-ShowOutput]
```

There are no tests — correctness is verified by running and checking the printed answer against the known Project Euler answer.

## Solution Conventions

Every `app.d` follows the same pattern:

1. **Header comment** — problem title and URL (`// Title\n// https://projecteuler.net/problem=N`)
2. **Imports** — `euler.math` utilities as needed, always `euler.common : runSolution`
3. **Helper functions** — kept in the same `app.d` file if needed
4. **`solve()`** — returns the answer; no I/O, no timing
5. **`main()`** — single call to `runSolution!(solve, N)()`

```d
// Problem title
// https://projecteuler.net/problem=N

import euler.math : sieve;          // math utilities as needed
import euler.common : runSolution;

auto solve() {
    // ...
    return answer;
}

void main() { runSolution!(solve, N)(); }
```

`runSolution` starts the timer, calls `solve()`, then prints:

```
Project Euler #N
Answer: 12345
Elapsed time: 3 milliseconds.
```

**D idioms** — range pipelines (`iota`, `filter`, `map`, `sum`, etc. from `std.range` / `std.algorithm`) are preferred over imperative loops where they read naturally; heavier numerical work uses explicit loops.

## Shared library (`pe-common`)

### `euler.common`

| Symbol | Description |
|--------|-------------|
| `runSolution!(solver, N)()` | Times `solver()`, prints answer and elapsed milliseconds |

### `euler.math`

| Symbol | Description |
|--------|-------------|
| `isPrime(n)` | Trial division primality test — O(√n), any integral type |
| `sieve(n)` | Sieve of Eratosthenes — returns `bool[0..n]`, O(n log log n) |
| `nthPrime!T(n)` | nth prime as type `T` (default `int`), sized by Rosser's bound |
| `reverseDigits(n)` | Reverses the decimal digits of an integer |
| `isPalindrome(n)` | `true` if `n == reverseDigits(n)` |
| `largestPrimeFactor(n)` | Largest prime factor of `n` |
| `mod(a, b)` | True modulo — always non-negative, unlike D's `%` |
| `fib!T(n)` | nth Fibonacci number as type `T` (default `BigInt`); use `fib!long(n)` for n ≤ 93 |
| `matMul(A, B, modulus)` | 2×2 matrix multiplication mod `modulus` |
| `matVecMul(M, v, modulus)` | 2×2 matrix × 2-vector multiplication mod `modulus` |
| `matPow(M, n, modulus)` | 2×2 matrix power `M^n` mod `modulus`; `n` may be any integral type or `BigInt` |

### `euler.numerics`

| Symbol | Description |
|--------|-------------|
| `Method` | Enum: `NewtonRaphson`, `Brent`, `Toms748`, `Itp` |
| `label(m)` | Human-readable name for a `Method` value |
| `SolveResult` | Result struct — `method` (Method), `root` (double), `evals` (size_t) |
| `Solver(method, a, b, func)` | Configures a solve for f(r) = 0 on [a, b]; `func` is `double delegate(double) pure nothrow @nogc` |
| `Solver.solve()` | Runs the selected algorithm; returns `SolveResult` |
