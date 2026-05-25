// Digit Factorials
// https://projecteuler.net/problem=34

import euler.common  : runSolution;

// Upper bound: 8 × 9! = 2_903_040 has only 7 digits, so no 8-digit number qualifies.
private enum uint limit = 7u * 362_880u;

auto solve()
{
    import euler.math     : digitFactSum;
    import std.range      : iota;
    import std.algorithm  : filter, sum;
    // 1! = 1 and 2! = 2 are excluded by the problem (not sums); start at 3.
    return iota(3u, limit + 1u).filter!(n => digitFactSum(n) == n).sum;
}

void main() { runSolution!(solve)(34); }
