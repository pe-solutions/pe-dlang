// Large Repunit Factors
// https://projecteuler.net/problem=132

import euler.common : runSolution;

auto solve() {
    import euler.math : isPrime;

    // p | R(10^9) iff ord_p(10) | 10^9 iff 10^(10^9) ≡ 1 (mod p).
    // p=2,5: gcd(p,10)≠1, repunits never divisible by 2 or 5.
    // p=3: 10 ≡ 1 (mod 3) always → ord_3(10)=1 | any exponent, false positive; skip.
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

    long sum = 0;
    int  cnt = 0;
    for (long p = 7; cnt < 40; p++) {
        if (!isPrime(p)) continue;
        if (modpow(10, 1_000_000_000L, p) == 1) {
            sum += p;
            cnt++;
        }
    }
    return sum;
}

void main() { runSolution!(solve)(132); }
