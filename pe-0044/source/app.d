// Pentagon Numbers
// https://projecteuler.net/problem=44

import euler.common : runSolution;

private long pent(long n) pure nothrow @nogc { return n * (3 * n - 1) / 2; }

private bool isPent(long n) pure nothrow @nogc
{
    import std.math : sqrt;
    immutable d = 24 * n + 1;
    immutable s = cast(long)(sqrt(cast(real) d));
    if (s * s == d) return (s + 1) % 6 == 0;
    immutable s1 = s + 1;
    return s1 * s1 == d && (s1 + 1) % 6 == 0;
}

auto solve()
{
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
