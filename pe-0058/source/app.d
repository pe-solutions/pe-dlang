// Spiral Primes
// https://projecteuler.net/problem=58

import euler.common : runSolution;

private long modpow(long b, long e, long m) pure nothrow @nogc
{
    long r = 1; b %= m;
    for (; e > 0; e >>= 1) { if (e & 1) r = r * b % m; b = b * b % m; }
    return r;
}

// Deterministic Miller-Rabin; exact for n < 3_215_031_751 with witnesses {2,3,5,7}.
private bool isPrime(long n) pure nothrow @nogc
{
    if (n < 2) return false;
    static immutable long[4] w = [2, 3, 5, 7];
    foreach (p; w) if (n == p) return true;
    if (!(n & 1) || n % 3 == 0 || n % 5 == 0) return false;
    long d = n - 1; int r = 0;
    while (!(d & 1)) { d >>= 1; ++r; }
    outer: foreach (a; w)
    {
        long x = modpow(a, d, n);
        if (x == 1 || x == n - 1) continue;
        foreach (_; 1 .. r) { x = x * x % n; if (x == n - 1) continue outer; }
        return false;
    }
    return true;
}

auto solve()
{
    long primes = 0;

    for (long k = 1; ; ++k)
    {
        immutable long s  = 2 * k + 1;
        immutable long sq = s * s;
        immutable long d  = s - 1;  // gap between consecutive diagonal corners
        // sq is a perfect square — never prime; test the other three corners.
        if (isPrime(sq - d))     ++primes;
        if (isPrime(sq - 2 * d)) ++primes;
        if (isPrime(sq - 3 * d)) ++primes;
        // Total diagonal count = 1 + 4k; stop when prime ratio drops below 10%.
        if (10 * primes < 1 + 4 * k) return s;
    }
}

void main() { runSolution!(solve)(58); }
