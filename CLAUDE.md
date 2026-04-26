# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

D language (DMD/DUB) solutions to [Project Euler](https://projecteuler.net/) problems. Each problem lives in its own isolated DUB package under `pe-XXXX/`.

## Commands

All commands are run from within a specific problem directory, e.g. `pe-0001/`.

```bash
# Build
dub build

# Run (builds if needed)
dub run

# Build in release mode (faster execution)
dub run --build=release
```

There are no tests — each solution's correctness is verified by running it and checking the printed answer against the known Project Euler answer.

## Structure

Each `pe-XXXX/` directory is a self-contained DUB package:
- `dub.json` — minimal package manifest (name, description, author)
- `source/app.d` — the entire solution in a single file

## Solution Conventions

Every `app.d` follows the same pattern:

1. **Header comment** — problem title and URL (`// Title\n// https://projecteuler.net/problem=N`)
2. **Timer** — `StopWatch(AutoStart.yes)` started at the top of `main()`, stopped before output
3. **Output** — `writefln("\nProject Euler #N\nAnswer: %s", answer)` followed by elapsed milliseconds
4. **D idioms** — range pipelines (`iota`, `filter`, `map`, `sum`, etc. from `std.range` / `std.algorithm`) are preferred over imperative loops where they read naturally; heavier numerical work uses explicit loops

When adding a new problem, follow this template and keep helper functions in the same `app.d` file.
