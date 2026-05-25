// Odd Period Square Roots
// https://projecteuler.net/problem=64

import euler.common : runSolution;

auto solve() {
    import euler.math : cfPeriod;
    int count = 0;
    foreach (n; 2 .. 10_001)
        if (cfPeriod(n) % 2 == 1) ++count;
    return count;
}

void main() { runSolution!(solve)(64); }
