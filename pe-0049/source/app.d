// Prime Permutations
// https://projecteuler.net/problem=49

import euler.common : runSolution;

auto solve()
{
    import euler.math : isPrime, digitFreq;
    enum int step = 3330;

    for (int a = 1488; a <= 9999 - 2 * step; ++a)
    {
        int b = a + step, c = b + step;
        if (isPrime(a) && isPrime(b) && isPrime(c) &&
            digitFreq(a) == digitFreq(b) && digitFreq(b) == digitFreq(c))
            return 100_000_000L * a + 10_000L * b + c;
    }
    assert(false);
}

void main() { runSolution!(solve)(49); }
