// The Tournament
// https://projecteuler.net/problem=849

import std.algorithm : max;
import euler.math : mod;
import euler.common : runSolution;

long f_alternate(long numIterations, long moduloValue) {
    long maxs = 2 * numIterations * (numIterations - 1);
    long maxd = 4 * (numIterations - 1);

    long[][] dp;
    foreach (i; 0 .. numIterations + 1)
        dp ~= new long[maxs + 1];

    dp[0][0] = 1;

    for (long d = 0; d <= maxd; ++d) {
        for (long i = 1; i <= numIterations; ++i) {
            for (long s = max(d, 2 * i * (i - 1)); s <= maxs; ++s) {
                dp[i][s] = mod(dp[i][s] + dp[i - 1][s - d], moduloValue);
            }
        }
    }

    return dp[numIterations][maxs];
}

auto solve() {
    return f_alternate(100L, 10L^^9 + 7);
}

void main() { runSolution!(solve, 849)(); }
