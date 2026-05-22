// Quadratic Primes
// https://projecteuler.net/problem=27

import euler.common : runSolution;

auto solve()
{
    import euler.math : sieve;
    enum limit = 100_000;
    immutable s = sieve(limit);

    int bestLen = 0, bestProd = 0;

    foreach (b; 2 .. 1000)
    {
        if (!s[b]) continue;
        // f(1) = 1+a+b must be an odd prime, so a and b must share parity
        for (int a = b == 2 ? -998 : -999; a < 1000; a += 2)
        {
            int n = 0;
            for (int v = b; v >= 2 && v <= limit && s[v]; ++n)
                v = (n + 1) * (n + 1) + a * (n + 1) + b;
            if (n > bestLen) { bestLen = n; bestProd = a * b; }
        }
    }
    return bestProd;
}

void main() { runSolution!(solve)(27); }
