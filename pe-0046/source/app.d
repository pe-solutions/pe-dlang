// Goldbach's Other Conjecture
// https://projecteuler.net/problem=46

import euler.math   : sieve;
import euler.common : runSolution;

auto solve()
{
    enum limit = 1_000_000;
    immutable s = sieve(limit);

    outer: for (int n = 9; n < limit; n += 2)
    {
        if (s[n]) continue;                      // skip primes
        for (int k = 1; 2 * k * k < n; ++k)
            if (s[n - 2 * k * k]) continue outer; // conjecture holds
        return n;
    }
    assert(false);
}

void main() { runSolution!(solve)(46); }
