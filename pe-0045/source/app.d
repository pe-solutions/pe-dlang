// Triangular, Pentagonal, and Hexagonal
// https://projecteuler.net/problem=45

import euler.common : runSolution;

auto solve()
{
    import euler.math : isPent;
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
