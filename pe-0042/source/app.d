// Coded Triangle Numbers
// https://projecteuler.net/problem=42

import euler.common  : runSolution;

private enum string raw = import("data/words.txt");

private int wordScore(string token) pure nothrow @nogc
{
    int s = 0;
    foreach (c; token)
        if (c >= 'A' && c <= 'Z') s += c - 'A' + 1;
    return s;
}

auto solve()
{
    import std.algorithm  : count, splitter;
    import euler.math     : isTriangle;
    return raw.splitter(',').count!(w => isTriangle(wordScore(w)));
}

void main() { runSolution!(solve)(42); }
