// Arranged Probability
// https://projecteuler.net/problem=100

import euler.common : runSolution;

auto solve() {
    // 2b(b-1) = n(n-1)  ⟺  y²-2x²=-1  (x=2b-1, y=2n-1, a Pell equation).
    // Consecutive solutions satisfy the recurrence: n' = 6n - n_prev - 2 (same for b).
    long n0 = 1, b0 = 1;
    long n1 = 4, b1 = 3;
    while (n1 <= 1_000_000_000_000L) {
        long n2 = 6 * n1 - n0 - 2;
        long b2 = 6 * b1 - b0 - 2;
        n0 = n1; b0 = b1;
        n1 = n2; b1 = b2;
    }
    return b1;
}

void main() { runSolution!(solve)(100); }
