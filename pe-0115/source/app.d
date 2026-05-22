// Counting Block Combinations II
// https://projecteuler.net/problem=115

import euler.common : runSolution;

auto solve() {
    // Generalisation of #114 with minimum red length m=50.
    // Same differencing derivation gives: f(n) = 2·f(n-1) − f(n-2) + f(n-m-1).
    // Base cases: f(0..m-1) = 1 (all-black only), f(m) = 2.
    // Find the least n such that f(m=50, n) > 1_000_000.
    enum int  m     = 50;
    enum long LIMIT = 1_000_000;
    long[] f = new long[m + 1];
    foreach (ref v; f) v = 1;
    f[m] = 2;
    for (int n = m + 1; ; n++) {
        f ~= 2 * f[n - 1] - f[n - 2] + f[n - m - 1];
        if (f[n] > LIMIT) return n;
    }
    assert(false);
}

void main() { runSolution!(solve)(115); }
