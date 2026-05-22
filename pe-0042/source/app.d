// Coded Triangle Numbers
// https://projecteuler.net/problem=42

import euler.common  : runSolution;

private enum string raw = import("data/words.txt");

// n is triangular iff 1 + 8n is a perfect square.
private bool isTriangle(int n) pure nothrow @nogc
{
    import euler.math : isPerfectSquare;
    return isPerfectSquare(1 + 8 * n);
}

private int wordScore(string token) pure nothrow @nogc
{
    int s = 0;
    foreach (c; token)
        if (c >= 'A' && c <= 'Z') s += c - 'A' + 1;
    return s;
}

auto solve()
{
    import std.algorithm : count, splitter;
    return raw.splitter(',').count!(w => isTriangle(wordScore(w)));
}

void main() { runSolution!(solve)(42); }
