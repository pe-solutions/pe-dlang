// Distinct Primes Factors
// https://projecteuler.net/problem=47

import euler.common : runSolution;

ulong[] generateOmegaSieve(ulong limit) {
    ulong[] omegaSieve = new ulong[](limit);
    for (ulong i = 2; i < limit; i++)
        if (omegaSieve[i] == 0)
            for (ulong j = i; j < limit; j += i)
                omegaSieve[j]++;
    return omegaSieve;
}

auto solve() {
    const ulong limit = 135_000;
    const ulong requiredFactors = 4;
    auto omegaSieve = generateOmegaSieve(limit);
    for (ulong i = 1; i < limit - requiredFactors; i++) {
        bool found = true;
        for (ulong j = 0; j < requiredFactors; j++)
            if (omegaSieve[i + j] != requiredFactors) { found = false; break; }
        if (found) return i;
    }
    return 0uL;
}

void main() { runSolution!(solve)(47); }
