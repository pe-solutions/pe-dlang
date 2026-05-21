// Truncatable Primes
// https://projecteuler.net/problem=37

import euler.math   : sieve;
import euler.common : runSolution;

private bool isRightTrunc(int n, const bool[] s) pure nothrow @nogc
{
    for (int t = n / 10; t > 0; t /= 10)
        if (!s[t]) return false;
    return true;
}

private bool isLeftTrunc(int n, const bool[] s) pure nothrow @nogc
{
    int pow10 = 1;
    for (int t = n; t >= 10; t /= 10) pow10 *= 10;
    for (int t = n; pow10 > 1; pow10 /= 10)
    {
        t %= pow10;
        if (!s[t]) return false;
    }
    return true;
}

auto solve()
{
    enum int limit = 1_000_000;
    immutable s = sieve(limit);
    long total = 0;
    int  found = 0;

    foreach (n; 11 .. limit)   // single-digit primes excluded by definition
    {
        if (!s[n]) continue;
        if (isRightTrunc(n, s) && isLeftTrunc(n, s))
        {
            total += n;
            if (++found == 11) break;
        }
    }

    return total;
}

void main() { runSolution!(solve)(37); }
