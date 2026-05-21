// Coin Partitions
// https://projecteuler.net/problem=78

import euler.common : runSolution;

auto solve() {
    enum int mod = 1_000_000;
    int[] p = [1];  // p[0] = 1

    for (int n = 1; ; ++n) {
        long pn = 0;
        for (int k = 1; ; ++k) {
            immutable int g1 = k * (3*k - 1) / 2;  // pentagonal(k)
            if (g1 > n) break;
            immutable int g2 = k * (3*k + 1) / 2;  // pentagonal(-k)
            immutable int sign = (k & 1) ? 1 : -1;
            pn += sign * p[n - g1];
            if (g2 <= n) pn += sign * p[n - g2];
        }
        p ~= cast(int)(((pn % mod) + mod) % mod);
        if (p[n] == 0) return n;
    }
}

void main() { runSolution!(solve)(78); }
