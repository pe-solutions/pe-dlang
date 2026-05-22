// Counting Block Combinations I
// https://projecteuler.net/problem=114

import euler.common : runSolution;

auto solve() {
    // f(n) = ways to fill n units with black (1-unit) and red (≥3-unit) tiles,
    // at least one black required between any two red blocks.
    //
    // f(n) = f(n-1) [prepend black]
    //      + Σ_{k=3..n} [k<n ? f(n-k-1) : 1]  [prepend red-k, then force one black gap]
    //
    // Differencing successive terms eliminates the running sum:
    //   f(n) = 2·f(n-1) − f(n-2) + f(n-4)
    enum int N = 50;
    long[N + 1] f;
    f[0] = 1; f[1] = 1; f[2] = 1; f[3] = 2;
    foreach (n; 4 .. N + 1)
        f[n] = 2 * f[n - 1] - f[n - 2] + f[n - 4];
    return f[N];
}

void main() { runSolution!(solve)(114); }
