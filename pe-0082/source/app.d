// Path Sum: Three Ways
// https://projecteuler.net/problem=82

import std.algorithm : min, minElement;
import std.array : split;
import std.conv : to;
import std.string : splitLines;
import euler.common : runSolution;

auto solve() {
    enum int N = 80;
    static immutable int[N][N] grid = () {
        int[N][N] g;
        foreach (r, line; import("data/matrix.txt").splitLines)
            foreach (c, tok; line.split(","))
                g[r][c] = tok.to!int;
        return g;
    }();

    long[N] dp;
    foreach (i; 0 .. N) dp[i] = grid[i][0];

    foreach (c; 1 .. N) {
        foreach (i; 0 .. N) dp[i] += grid[i][c];
        foreach (i; 1 .. N)   dp[i] = min(dp[i], dp[i-1] + grid[i][c]);
        foreach_reverse (i; 0 .. N-1) dp[i] = min(dp[i], dp[i+1] + grid[i][c]);
    }
    return dp[].minElement;
}

void main() { runSolution!(solve)(82); }
