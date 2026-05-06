// Number Spiral Diagonals
// https://projecteuler.net/problem=28

import euler.common : runSolution;

long sumOfSpiralDiagonals(const long n) =>
    (4L * n^^3L + 3L * n^^2L + 8L * n - 9L) / 6L;

auto solve() { return sumOfSpiralDiagonals(1_001L); }

void main() { runSolution!(solve)(28); }
