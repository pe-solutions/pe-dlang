// The Tournament
// https://projecteuler.net/problem=849

import std.algorithm : max;
import euler.common : runSolution;

long f_alternate(long numIterations, long moduloValue) {
    long maxs = 2 * numIterations * (numIterations - 1);
    long maxd = 4 * (numIterations - 1);

    int stride = cast(int)(maxs + 1);
    auto dp = new int[(numIterations + 1) * stride];

    dp[0] = 1;

    for (long d = 0; d <= maxd; ++d) {
        for (long i = 1; i <= numIterations; ++i) {
            int* cur  = dp.ptr + i       * stride;
            int* prev = dp.ptr + (i - 1) * stride;
            for (long s = max(d, 2 * i * (i - 1)); s <= maxs; ++s) {
                auto r = cur[s] + prev[s - d];
                cur[s] = r >= moduloValue ? cast(int)(r - moduloValue) : cast(int)r;
            }
        }
    }

    return dp[numIterations * stride + maxs];
}

auto solve() {
    return f_alternate(100L, 10L^^9 + 7);
}

void main() { runSolution!(solve)(849); }
