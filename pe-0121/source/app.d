// Disc Game Prize Fund
// https://projecteuler.net/problem=121

import euler.common : runSolution;

auto solve() {
    // Turn i: P(blue) = 1/(i+1), P(red) = i/(i+1).
    // dp[k] = numerator of P(exactly k blue in n turns), denominator = (n+1)!
    // Transition: dp[k] = dp[k-1] + dp[k]*n  (right-to-left avoids overwrite).
    enum int N = 15;
    long[N + 1] dp;
    dp[0] = 1;
    foreach (n; 1 .. N + 1) {
        foreach_reverse (k; 1 .. n + 1)
            dp[k] = dp[k - 1] + dp[k] * n;
        dp[0] *= n;
    }
    long D = 1;
    foreach (i; 2 .. N + 2) D *= i;          // D = (N+1)! = 16!
    long win = 0;
    foreach (k; N / 2 + 1 .. N + 1)          // blue > red ⟺ k ≥ 8
        win += dp[k];
    return D / win;
}

void main() { runSolution!(solve)(121); }
