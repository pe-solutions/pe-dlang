// Triangular, Pentagonal, and Hexagonal
// https://projecteuler.net/problem=45

import std.math     : sqrt;
import euler.common : runSolution;

// n is pentagonal iff 24n+1 is a perfect square s and (s+1) % 6 == 0
private bool isPent(long n) pure nothrow @nogc
{
    immutable d = 24 * n + 1;
    immutable s = cast(long)(sqrt(cast(real) d));
    if (s * s == d) return (s + 1) % 6 == 0;
    immutable s1 = s + 1;
    return s1 * s1 == d && (s1 + 1) % 6 == 0;
}

auto solve()
{
    // H_n = n(2n-1) is always triangular (equals T_{2n-1}),
    // so only test hexagonals for pentagonality.
    // H_143 = 40755 is the given example; start from n=144.
    for (long n = 144; ; ++n)
    {
        immutable h = n * (2 * n - 1);
        if (isPent(h)) return h;
    }
}

void main() { runSolution!(solve)(45); }
