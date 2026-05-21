// Counting Fractions
// https://projecteuler.net/problem=72

import euler.common : runSolution;

auto solve() {
    enum int N = 1_000_000;

    // Totient sieve: phi[i] starts as i; for each prime p divide out p-factors.
    auto phi = new int[N + 1];
    foreach (i; 0 .. N + 1) phi[i] = i;
    for (int p = 2; p <= N; ++p)
        if (phi[p] == p)
            for (int j = p; j <= N; j += p)
                phi[j] = phi[j] / p * (p - 1);

    // Count of reduced proper fractions n/d with d<=N equals sum of phi(d) for d=2..N.
    long total = 0;
    foreach (d; 2 .. N + 1)
        total += phi[d];
    return total;
}

void main() { runSolution!(solve)(72); }
