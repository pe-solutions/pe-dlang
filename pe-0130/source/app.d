// Composites with Prime Repunit Property
// https://projecteuler.net/problem=130

import euler.common : runSolution;

auto solve() {
    import std.numeric : gcd;
    import euler.math  : isPrime;

    // A(n) = min k s.t. n | R(k), computed via r=(r*10+1) mod n until r=0.
    // By Fermat / generalisation, A(n) | (n-1) for all primes n with gcd(n,10)=1.
    // Find the first 25 COMPOSITE n with gcd(n,10)=1 where A(n) | (n-1).
    long sum  = 0;
    int  hits = 0;

    for (long n = 3; hits < 25; n++) {
        if (gcd(n, 10L) != 1) continue;
        if (isPrime(n)) continue;
        long r = 1, k = 1;
        while (r != 0) { r = (r * 10 + 1) % n; k++; }
        if ((n - 1) % k == 0) { sum += n; hits++; }
    }
    return sum;
}

void main() { runSolution!(solve)(130); }
