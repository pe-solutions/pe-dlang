// Prime Pair Connection
// https://projecteuler.net/problem=134

import euler.common : runSolution;

auto solve() {
    import euler.math : sieve;

    // For each consecutive prime pair (p1,p2) with 5 ≤ p1 ≤ 10⁶:
    // find smallest S > 0 with p2|S and S ≡ p1 (mod m), m = 10^len(p1).
    // S = p2·k, k ≡ p1·(p2)⁻¹ (mod m) via extended Euclidean.
    // k ≠ 0: p1·inv ≡ 0 (mod m) would require p1 ≡ 0 (mod m), impossible since p1 < m.
    long modinv(long a, long m) pure nothrow @nogc {
        long r0 = a, r1 = m, s0 = 1, s1 = 0;
        while (r1 != 0) {
            immutable long q = r0 / r1;
            immutable long tr = r0 - q * r1; r0 = r1; r1 = tr;
            immutable long ts = s0 - q * s1; s0 = s1; s1 = ts;
        }
        return (s0 % m + m) % m;
    }

    auto isPr = sieve(1_100_000);
    long[] primes;
    foreach (long p; 2 .. 1_100_000L)
        if (isPr[p]) primes ~= p;

    long sum = 0;
    size_t i = 2;   // primes[2] = 5
    while (primes[i] <= 1_000_000) {
        immutable long p1 = primes[i];
        immutable long p2 = primes[i + 1];
        long m = 1;
        for (long t = p1; t > 0; t /= 10) m *= 10;
        sum += p2 * (p1 * modinv(p2 % m, m) % m);
        i++;
    }
    return sum;
}

void main() { runSolution!(solve)(134); }
