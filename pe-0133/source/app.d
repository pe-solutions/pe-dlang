// Repunit Non-factors
// https://projecteuler.net/problem=133

import euler.common : runSolution;

auto solve() {
    import euler.math : sieve;

    // p | R(10^n) for some n iff ord_p(10) | 10^n for some n
    // iff ord_p(10) is of the form 2^a·5^b (2-5-smooth).
    // Non-factor iff ord_p(10) has a prime factor other than 2 or 5
    //          iff 10^M ≢ 1 (mod p), where M = 2^16·5^7 = 5_120_000_000
    //          covers every 2-5-smooth order < 100 000.
    // Special cases: p=2,5 never divide repunits (gcd with 10 ≠ 1);
    //   p=3: R(10^n) ≡ 10^n ≡ 1 (mod 3) ≠ 0 for all n (ord formula doesn't
    //   apply since 3|9 — instead need ord_{27}(10)=3, not 2-5-smooth).
    enum long M = 5_120_000_000L;   // 2^16 * 5^7

    long modpow(long b, long e, long m) pure nothrow @nogc {
        long r = 1;
        b %= m;
        while (e > 0) {
            if (e & 1) r = r * b % m;
            b = b * b % m;
            e >>= 1;
        }
        return r;
    }

    enum long LIMIT = 100_000L;
    auto isPr = sieve(LIMIT);
    long sum = 2 + 3 + 5;
    foreach (long p; 7 .. LIMIT) {
        if (!isPr[p]) continue;
        if (modpow(10, M, p) != 1) sum += p;
    }
    return sum;
}

void main() { runSolution!(solve)(133); }
