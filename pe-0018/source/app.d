// Maximum Path Sum I
// https://projecteuler.net/problem=18

import std.string    : splitLines, split;
import std.conv      : to;
import std.algorithm : max;
import euler.common  : runSolution;

static immutable int[15][15] tri = () {
    int[15][15] t;
    foreach (r, line; import("data/triangle.txt").splitLines)
        foreach (c, tok; line.split)
            t[r][c] = tok.to!int;
    return t;
}();

auto solve() {
    int[15] dp = tri[14];
    foreach_reverse (i; 0 .. 14)
        foreach (j; 0 .. i + 1)
            dp[j] = tri[i][j] + max(dp[j], dp[j + 1]);
    return dp[0];
}

void main() { runSolution!(solve)(18); }
