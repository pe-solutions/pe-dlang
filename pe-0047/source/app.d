// Distinct Primes Factors
// https://projecteuler.net/problem=47

import euler.common : runSolution;

auto solve() {
    import euler.math : omegaSieve;
    enum ulong limit = 135_000;
    enum ulong requiredFactors = 4;
    auto omega = omegaSieve(limit);
    for (ulong i = 1; i < limit - requiredFactors; i++) {
        bool found = true;
        for (ulong j = 0; j < requiredFactors; j++)
            if (omega[i + j] != requiredFactors) { found = false; break; }
        if (found) return i;
    }
    return 0uL;
}

void main() { runSolution!(solve)(47); }
