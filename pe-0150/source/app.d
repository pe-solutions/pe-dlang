// Searching a Triangular Array for a Sub-triangle Having Minimum-sum
// https://projecteuler.net/problem=150

import euler.common : runSolution;

auto solve() {
    enum int N = 1000;

    // Build row prefix sums directly from the LCG.
    // rowpsum[r][c] = T[r][0] + ... + T[r][c-1], with rowpsum[r][0] = 0.
    auto rowpsum = new long[][](N);
    {
        long t = 0;
        for (int r = 0; r < N; ++r) {
            rowpsum[r] = new long[](r + 2);
            rowpsum[r][0] = 0;
            for (int c = 0; c <= r; ++c) {
                t = (615949 * t + 797807) & ((1L << 20) - 1);
                rowpsum[r][c + 1] = rowpsum[r][c] + (cast(int) t - (1 << 19));
            }
        }
    }

    // For each apex (r0, c0), extend downward row by row, accumulating the
    // sub-triangle sum and updating the running minimum.
    long minSum = long.max;

    for (int r0 = 0; r0 < N; ++r0)
        for (int c0 = 0; c0 <= r0; ++c0) {
            long s = 0;
            for (int h = 0; r0 + h < N; ++h) {
                s += rowpsum[r0 + h][c0 + h + 1] - rowpsum[r0 + h][c0];
                if (s < minSum) minSum = s;
            }
        }

    return minSum;
}

void main() { runSolution!(solve)(150); }
