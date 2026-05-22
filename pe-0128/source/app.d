// Hexagonal Tile Differences
// https://projecteuler.net/problem=128

import euler.common : runSolution;

auto solve() {
    import euler.math : isPrime;

    // Ring k: F(k)=3k²-3k+2 (first), L(k)=3k²+3k+1 (last).
    // Tiles with PD(n)=3 beyond the two initial ones are only F(k) and L(k) for k≥2.
    //
    // F(k) neighbour diffs: {1, 6(k-1), 6k-1, 6k, 6k+1, 12k+5}
    //   never-prime: 1, 6(k-1), 6k
    //   PD=3 iff isPrime(6k-1) && isPrime(6k+1) && isPrime(12k+5)
    //
    // L(k) neighbour diffs: {1, 6k-1, 6k, 12k-7, 6k+5, 6(k+1)}
    //   never-prime: 1, 6k, 6(k+1)
    //   PD=3 iff isPrime(6k-1) && isPrime(12k-7) && isPrime(6k+5)
    //
    // Tiles appear in order: 1, F(1)=2, [L(1)=7 skipped, PD=2], F(2), L(2), F(3), L(3), ...
    long count = 2;  // tile 1 (center) and tile 2 = F(1) are always PD=3

    for (long k = 2; ; k++) {
        if (isPrime(6*k - 1) && isPrime(6*k + 1) && isPrime(12*k + 5)) {
            if (++count == 2000) return 3*k*k - 3*k + 2;
        }
        if (isPrime(6*k - 1) && isPrime(12*k - 7) && isPrime(6*k + 5)) {
            if (++count == 2000) return 3*k*k + 3*k + 1;
        }
    }
    assert(false);
}

void main() { runSolution!(solve)(128); }
