// Totient Permutation
// https://projecteuler.net/problem=70

import euler.math : digitFreq;
import euler.common : runSolution;

auto solve() {
    enum int N = 10_000_000;

    // Euler's totient sieve: phi[p]==p on first visit iff p is prime.
    auto phi = new int[N + 1];
    foreach (i; 0 .. N + 1) phi[i] = i;
    for (int p = 2; p <= N; ++p)
        if (phi[p] == p)
            for (int j = p; j <= N; j += p)
                phi[j] = phi[j] / p * (p - 1);

    int bestN = 0, bestPhi = 1;
    foreach (n; 2 .. N) {
        immutable int t = phi[n];
        if (digitFreq(n) == digitFreq(t) &&
            (bestN == 0 || cast(long) n * bestPhi < cast(long) bestN * t)) {
            bestN = n;
            bestPhi = t;
        }
    }
    return bestN;
}

void main() { runSolution!(solve)(70); }
