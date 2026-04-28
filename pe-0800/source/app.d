// Hybrid Integers
// https://projecteuler.net/problem=800

import std.math : log;
import euler.math : sieve;
import euler.common : runSolution;

auto solve() {
    enum int B = 800_800;
    enum int E = 800_800;
    immutable double limit = E * log(cast(double)B);

    auto isPrime = sieve(16_000_000);
    int[] primes;
    foreach (i; 2 .. 16_000_001)
        if (isPrime[i]) primes ~= i;

    int count = 0;
    foreach (pi; 0 .. primes.length) {
        immutable p    = primes[pi];
        immutable logp = log(cast(double)p);
        if (2.0 * logp + p * log(2.0) > limit) break;

        // Binary search: first index in primes[pi+1..] where q*log(p) + p*log(q) > limit.
        size_t lo = pi + 1, hi = primes.length;
        while (lo < hi) {
            immutable mid = (lo + hi) / 2;
            immutable q   = primes[mid];
            if (cast(double)q * logp + p * log(cast(double)q) <= limit)
                lo = mid + 1;
            else
                hi = mid;
        }
        count += cast(int)(lo - (pi + 1));
    }
    return count;
}

void main() { runSolution!(solve, 800)(); }
