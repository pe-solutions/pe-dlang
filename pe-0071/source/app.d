// Ordered Fractions
// https://projecteuler.net/problem=71

import euler.common : runSolution;

auto solve() {
    enum int limit = 1_000_000;

    // For each d, the largest n with n/d < 3/7 is n = (3*d - 1) / 7.
    // Track best as cross-product comparison: bestN * d > n * bestD means n/d is closer.
    long bestN = 0, bestD = 1;
    foreach (d; 1 .. limit + 1) {
        immutable long n = (3L * d - 1) / 7;
        if (n * bestD > bestN * d) {
            bestN = n;
            bestD = d;
        }
    }
    return bestN;
}

void main() { runSolution!(solve)(71); }
