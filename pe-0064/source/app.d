// Odd Period Square Roots
// https://projecteuler.net/problem=64

import std.math : sqrt;
import euler.common : runSolution;

// Returns the CF period length of √n, or 0 for perfect squares.
private uint cfPeriod(int n) pure nothrow @nogc {
    immutable int a0 = cast(int) sqrt(cast(double) n);
    if (a0 * a0 == n) return 0;
    int m = 0, d = 1, a = a0;
    uint period = 0;
    do {
        m = d * a - m;
        d = (n - m * m) / d;
        a = (a0 + m) / d;
        ++period;
    } while (a != 2 * a0);
    return period;
}

auto solve() {
    int count = 0;
    foreach (n; 2 .. 10_001)
        if (cfPeriod(n) % 2 == 1) ++count;
    return count;
}

void main() { runSolution!(solve)(64); }
