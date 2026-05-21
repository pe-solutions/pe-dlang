// Digit Factorials
// https://projecteuler.net/problem=34

import std.range     : iota;
import std.algorithm : filter, sum;
import euler.common  : runSolution;

// Upper bound: 8 × 9! = 2_903_040 has only 7 digits, so no 8-digit number qualifies.
private enum uint limit = 7u * 362_880u;

private immutable uint[10] fact = [1, 1, 2, 6, 24, 120, 720, 5_040, 40_320, 362_880];

private uint digitFactSum(uint n) pure nothrow @nogc
{
    uint s = 0;
    while (n > 0) { s += fact[n % 10]; n /= 10; }
    return s;
}

auto solve()
{
    // 1! = 1 and 2! = 2 are excluded by the problem (not sums); start at 3.
    return iota(3u, limit + 1u).filter!(n => digitFactSum(n) == n).sum;
}

void main() { runSolution!(solve)(34); }
