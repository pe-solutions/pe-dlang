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
│       ├── math.d      # countDivisors, isPrime, sieve, segmentedSieve, nthPrime,
│       │               # reverseDigits, isPalindrome, digitFreq, isPerfectSquare, largestPrimeFactor,
│       │               # mod, fib, fibFirstNDigits, matMul, matVecMul, matPow
│       ├── rat.d       # Rat — exact rational arithmetic (GCD-reduced, long-backed)
│       └── numerics.d  # Solver, Method, SolveResult — root-finding
│                       # (Newton-Raphson, Brent-Dekker, TOMS 748, ITP)
├── pe-XXXX/            # One DUB package per problem
│   ├── dub.json
│   └── source/
│       ├── app.d
│       └── data/       # optional: problem-given data files (digits, grids, matrices)
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
2. **Imports** — `euler.math` and/or `euler.numerics` utilities as needed, always `euler.common : runSolution`
3. **Helper functions** — kept in the same `app.d` file if needed
4. **`solve()`** — returns the answer; no I/O, no timing
5. **`main()`** — single call to `runSolution!(solve)(N)`

```d
// Problem title
// https://projecteuler.net/problem=N

import euler.math : sieve;          // math utilities as needed
import euler.numerics : Solver, Method; // root-finding as needed
import euler.common : runSolution;

auto solve() {
    // ...
    return answer;
}

void main() { runSolution!(solve)(N); }
```

`runSolution` starts the timer, calls `solve()`, then prints:

```

Project Euler #N
Answer: 12345
Elapsed time: 3 milliseconds.

```

**Import layout** — stdlib imports precede all `euler.*` imports; `euler.common : runSolution` is always the last import in the file.

**D idioms** — range pipelines (`iota`, `filter`, `map`, `sum`, etc. from `std.range` / `std.algorithm`) are preferred over imperative loops where they read naturally; heavier numerical work uses explicit loops.

**Module-level helpers** — always mark `private`; always give an explicit return type (never `auto`); apply `pure nothrow @nogc` to any helper whose body is pure arithmetic with no allocation or exceptions:

```d
private bool isPent(long n) pure nothrow @nogc { … }
private uint digitMask(int n) pure nothrow @nogc { … }
```

**Nested functions** — when a helper must capture and mutate `solve()`-local state (e.g., a DFS accumulator), define it as a nested function inside `solve()` — not a module-level function. No `private`, no attribute annotation:

```d
auto solve() {
    long total;
    void build(int depth) { … total += …; }
    build(0);
    return total;
}
```

**Constants** — use `enum` for compile-time scalar constants inside `solve()`, never `const` or bare magic numbers:

```d
enum int N      = 10_000;
enum     limit  = 1_000_000;
enum uint full  = 0x3FEu;
```

**`immutable` for per-iteration invariants** — when a value is computed once per outer-loop iteration and read repeatedly in the inner loop, bind it to `immutable` at the outer scope:

```d
foreach (a; 10 .. 100) {
    immutable ma = digitMask(a);   // hoisted — not recomputed inside inner loop
    foreach (b; 100 .. 1_000) { … }
}
```

**Control flow**
- Prefer `break` over a re-checked `continue` when an inner loop variable is monotonically increasing and exceeding a bound makes all further iterations useless.
- Use a labeled block (`outer: for (…) { … continue outer; }`) rather than a flag variable for multi-level loop control.
- End an exhaustive-search loop that is guaranteed to return before completion with `assert(false)` to signal the unreachable path:

```d
outer: for (int n = 9; n < limit; n += 2) {
    for (int k = 1; …; ++k)
        if (…) continue outer;
    return n;           // found
}
assert(false);          // unreachable — search always terminates
```

**Deduplication** — a flat `bool[N]` array is the preferred structure for set membership and result deduplication; stack-allocated for small N, it avoids AA allocation and GC overhead:

```d
bool[10_000] seen;
…
seen[c] = true;
…
return iota(1_000, 10_000).filter!(i => seen[i]).sum;
```

**External data** — when a problem supplies a large dataset (digit strings, grids, matrices), store it in `source/data/` and embed it at compile time rather than hardcoding it inline:

1. Add `"stringImportPaths": ["source"]` to `dub.json`
2. Use `import("data/file.txt")` to pull the file in as a compile-time string
3. Use `enum` for a plain string, `static immutable` for arrays
4. Parse with `splitLines`, `join`, `split`, `to!int`, or a CTFE lambda — D evaluates all of these at compile time, so there is zero runtime cost

```d
// Plain string (e.g. a digit sequence) — entire pipeline becomes CTFE:
enum string data = import("data/digits.txt").splitLines.join;

// 2D integer array (e.g. a grid or matrix):
static immutable int[R][C] grid = () {
    int[R][C] result;
    foreach (r, line; import("data/grid.txt").splitLines)
        foreach (c, tok; line.split)
            result[r][c] = tok.to!int;
    return result;
}();
```

Never hardcode large data blobs inline — this pattern gives identical binary embedding with readable, maintainable source. Similarly, never hardcode derived numeric data (e.g. a list of primes) when a library function from `euler.math` can generate it; prefer `sieve()` over a raw array literal.

## Shared library (`pe-common`)

### `euler.common`

| Symbol | Description |
|--------|-------------|
| `runSolution!(solver)(N)` | Times `solver()`, prints answer and elapsed milliseconds |

### `euler.math`

| Symbol | Description |
|--------|-------------|
| `countDivisors(n)` | Number of divisors via prime factorisation — O(√n), any integral type |
| `isPrime(n)` | Trial division primality test — O(√n), any integral type |
| `sieve(n)` | Sieve of Eratosthenes — returns `bool[0..n]`, O(n log log n) |
| `segmentedSieve(lo, hi)` | Range sieve — returns `bool[]` where `result[i]` is true iff `lo+i` is prime; O(hi-lo + √hi) memory |
| `nthPrime!T(n)` | nth prime as type `T` (default `int`), sized by Rosser's bound |
| `reverseDigits(n)` | Reverses the decimal digits of an integer |
| `isPalindrome(n)` | `true` if `n == reverseDigits(n)` |
| `digitFreq(n)` | Digit-frequency fingerprint as a `ulong` (nibble per digit 0–9); `digitFreq(a) == digitFreq(b)` iff `a` and `b` are digit permutations of each other — any integral type |
| `isPerfectSquare(n)` | `true` if `n` is a perfect square — any integral type |
| `largestPrimeFactor(n)` | Largest prime factor of `n` |
| `mod(a, b)` | True modulo — always non-negative, unlike D's `%` |
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
| `Method` | Enum: `NewtonRaphson`, `Brent`, `Toms748`, `Itp` |
| `label(m)` | Human-readable name for a `Method` value |
| `SolveResult` | Result struct — `method` (Method), `root` (double), `evals` (size_t) |
| `Solver(method, a, b, func)` | Configures a solve for f(r) = 0 on [a, b]; `func` is `double delegate(double) pure nothrow @nogc` |
| `Solver.solve()` | Runs the selected algorithm; returns `SolveResult` |
