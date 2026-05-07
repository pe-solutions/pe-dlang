# Dlang Project Euler solutions

<p align="center"><img src="logo.png"></p>

I followed the ins and outs of [DMD](https://dlang.org/) since early 2004 when the _"Great Divide"_ Phobos/Tango debate was still prevalent.

I ❤️ D and mostly `Math'n code` too!

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
│       ├── math.d      # countDivisors, isPrime, sieve, segmentedSieve, nthPrime,
│       │               # reverseDigits, isPalindrome, largestPrimeFactor,
│       │               # mod, fib, matMul, matVecMul, matPow
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

## Solution conventions

Every `app.d` follows the same pattern:

```d
// Problem title
// https://projecteuler.net/problem=N

import ...;
import euler.math : ...;       // math utilities as needed
import euler.numerics : ...;   // root-finding as needed
import euler.common : runSolution;

// helper functions if any

auto solve() {
    // ...
    return answer;
}

void main() { runSolution!(solve)(N); }
```

`runSolution` handles the timer and output format:

```

Project Euler #N
Answer: 12345
Elapsed time: 3 milliseconds.

```

---

## Further reading

- [Shared library reference](LIBRARY.md) — `euler.common`, `euler.math`, `euler.numerics` API
- [Solutions](SOLUTIONS.md) — full list with approaches
