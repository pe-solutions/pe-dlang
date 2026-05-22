// Digit Fifth Powers
// https://projecteuler.net/problem=30

import euler.common  : runSolution;

// Upper bound: 7 × 9^5 = 413343 has only 6 digits, so no 7-digit number qualifies.
private enum uint limit = 6u * 59_049u;

private immutable uint[10] p5 = [0, 1, 32, 243, 1024, 3125, 7776, 16807, 32768, 59049];

private uint dp5(uint n) pure nothrow @nogc
{
    uint s = 0;
    while (n > 0) { s += p5[n % 10]; n /= 10; }
    return s;
}

auto solve()
{
    import std.range     : iota;
    import std.algorithm : filter, sum;
    return iota(2u, limit + 1u).filter!(n => dp5(n) == n).sum;
}

void main() { runSolution!(solve)(30); }
