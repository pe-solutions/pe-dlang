// Circular Primes
// https://projecteuler.net/problem=35

import euler.common : runSolution;

private bool allOddNon5(int n) pure nothrow @nogc
{
    while (n > 0)
    {
        immutable d = n % 10;
        if (d % 2 == 0 || d == 5) return false;
        n /= 10;
    }
    return true;
}

private int rotate(int n, int pow10) pure nothrow @nogc
{
    immutable top = n / pow10;
    return (n - top * pow10) * 10 + top;
}

auto solve()
{
    import euler.math : sieve;
    enum int limit = 1_000_000;
    immutable s = sieve(limit);
    int count = 0;

    foreach (n; 2 .. limit)
    {
        if (!s[n]) continue;
        if (n < 10) { ++count; continue; }
        if (!allOddNon5(n)) continue;

        int pow10 = 1;
        for (int t = n; t >= 10; t /= 10) pow10 *= 10;

        bool circular = true;
        int rot = n;
        do {
            rot = rotate(rot, pow10);
            if (!s[rot]) { circular = false; break; }
        } while (rot != n);

        if (circular) ++count;
    }

    return count;
}

void main() { runSolution!(solve)(35); }
