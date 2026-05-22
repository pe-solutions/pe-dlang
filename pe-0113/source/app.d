// Non-bouncy Numbers
// https://projecteuler.net/problem=113

import euler.common : runSolution;

auto solve() {
    import euler.math : binomial;
    // n-digit increasing = C(n+8,8) (multisets of n from {1..9}).
    // n-digit decreasing = C(n+9,9) − 1 (multisets from {0..9}, minus all-zeros row).
    // Hockey-stick: Σ_{n=1}^{N} C(n+r,r) = C(N+r+1, r+1) − 1.
    // Repdigits (simultaneously increasing and decreasing) subtract 9×N to avoid double-count.
    enum int N = 100;
    immutable inc = binomial(N + 9,  9)  - 1L;      // Σ C(n+8,8), n=1..N
    immutable dec = binomial(N + 10, 10) - 1L - N;  // Σ (C(n+9,9)−1), n=1..N
    return inc + dec - 9L * N;
}

void main() { runSolution!(solve)(113); }
