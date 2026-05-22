// Spiral Primes
// https://projecteuler.net/problem=58

import euler.common : runSolution;

auto solve()
{
    import euler.math : isPrime;
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
