// Path Sum: Two Ways
// https://projecteuler.net/problem=81

import std.algorithm : min;
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

    long[N][N] dp;
    dp[0][0] = grid[0][0];
    foreach (j; 1 .. N) dp[0][j] = dp[0][j-1] + grid[0][j];
    foreach (i; 1 .. N) {
        dp[i][0] = dp[i-1][0] + grid[i][0];
        foreach (j; 1 .. N)
            dp[i][j] = grid[i][j] + min(dp[i-1][j], dp[i][j-1]);
    }
    return dp[N-1][N-1];
}

void main() { runSolution!(solve)(81); }
