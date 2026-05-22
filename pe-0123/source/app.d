// Prime Square Remainders
// https://projecteuler.net/problem=123

import euler.common : runSolution;

auto solve() {
    import euler.math : sieve;
    import std.algorithm : filter;
    import std.range    : iota;
    import std.array    : array;

    // Same binomial result as #120: even n → r=2; odd n → r = 2n·p_n mod p_n².
    // For large n (where 2n < p_n) the mod is a no-op, so r = 2n·p_n directly.
    // Find the first odd n where r > 10^10.
    enum long TARGET = 10_000_000_000L;

    auto s = sieve(1_500_000);   // ~114 000 primes; more than enough headroom
    auto primes = iota(2, 1_500_001).filter!(i => s[i]).array;

    for (int n = 1; n < cast(int)primes.length; n += 2) {
        immutable long p = primes[n - 1];
        immutable long r = (2L * n * p) % (p * p);
        if (r > TARGET) return n;
    }
    assert(false);
}

void main() { runSolution!(solve)(123); }
