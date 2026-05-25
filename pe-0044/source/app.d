// Pentagon Numbers
// https://projecteuler.net/problem=44

import euler.common : runSolution;

auto solve()
{
    import euler.math : pent, isPent;
    long best = long.max;
    for (long k = 2; 3 * k - 2 < best; ++k)
    {
        immutable pk = pent(k);
        for (long j = k - 1; j >= 1; --j)
        {
            immutable pj  = pent(j);
            immutable diff = pk - pj;
            if (diff >= best) break;
            if (isPent(diff) && isPent(pk + pj)) best = diff;
        }
    }
    return best;
}

void main() { runSolution!(solve)(44); }
