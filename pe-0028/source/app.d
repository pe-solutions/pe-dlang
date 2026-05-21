// Number Spiral Diagonals
// https://projecteuler.net/problem=28

import euler.common : runSolution;

private long sumOfSpiralDiagonals(long n) pure nothrow @nogc =>
    (4L * n^^3L + 3L * n^^2L + 8L * n - 9L) / 6L;

auto solve() { return sumOfSpiralDiagonals(1_001L); }

void main() { runSolution!(solve)(28); }
