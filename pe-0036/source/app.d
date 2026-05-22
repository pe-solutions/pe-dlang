// Double-base Palindromes
// https://projecteuler.net/problem=36

import euler.common  : runSolution;

// Reverse the bits of n, stopping at the most-significant set bit (no leading zeros).
private bool isBinPalindrome(int n) pure nothrow @nogc
{
    int r = 0, t = n;
    while (t > 0) { r = (r << 1) | (t & 1); t >>= 1; }
    return r == n;
}

auto solve()
{
    import std.range     : iota;
    import std.algorithm : filter, sum;
    import euler.math    : isPalindrome;
    // Binary palindromes must be odd: leading bit == 1 == trailing bit.
    return iota(1, 1_000_000, 2)
        .filter!(n => isPalindrome(n) && isBinPalindrome(n))
        .sum;
}

void main() { runSolution!(solve)(36); }
