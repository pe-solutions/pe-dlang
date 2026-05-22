// Prime Digit Replacements
// https://projecteuler.net/problem=51

import euler.common : runSolution;

auto solve()
{
    import euler.math : sieve;
    enum int limit = 1_000_000;
    immutable s = sieve(limit);

    foreach (n; 2 .. limit)
    {
        if (!s[n]) continue;

        // Extract digits least-significant first, and their powers of ten.
        int[6] digs;
        int[6] pow10;
        int    ndig = 0;
        pow10[0] = 1;
        for (int t = n; t > 0; t /= 10)
        {
            digs[ndig] = t % 10;
            if (ndig > 0) pow10[ndig] = pow10[ndig - 1] * 10;
            ++ndig;
        }

        // Try every non-empty subset of digit positions as the wildcard set.
        foreach (mask; 1 .. (1 << ndig))
        {
            int count = 0, smallest = int.max;
            foreach (r; 0 .. 10)
            {
                // A leading zero would reduce the digit count — skip.
                if (r == 0 && (mask >> (ndig - 1)) & 1) continue;

                // Replace each masked position with r.
                int val = n;
                foreach (i; 0 .. ndig)
                    if ((mask >> i) & 1)
                        val += (r - digs[i]) * pow10[i];

                if (val < limit && s[val])
                {
                    ++count;
                    if (val < smallest) smallest = val;
                }
            }
            if (count >= 8) return smallest;
        }
    }

    assert(false);
}

void main() { runSolution!(solve)(51); }
