// Matrix Sum
// https://projecteuler.net/problem=345

import std.string : splitLines, split;
import std.conv : to;
import euler.common : runSolution;

enum N = 15;
enum N2 = 1 << N;

// Matrix parsed from file at compile time via CTFE.
static immutable int[N][N] a = () {
    int[N][N] result;
    foreach (r, line; import("data/matrix_15x15.txt").splitLines)
        foreach (c, tok; line.split)
            result[r][c] = tok.to!int;
    return result;
}();

auto solve() {
    static int[N2][N+1] dp;
    foreach (n; 0 .. N) {
        foreach (c; 0 .. N2) {
            dp[n+1][c] = dp[n][c];
            foreach (x; 0 .. N) {
                if ((1 << x) & c) {
                    auto r = a[n][x] + dp[n][c - (1 << x)];
                    if (dp[n+1][c] < r) dp[n+1][c] = r;
                }
            }
        }
    }
    return dp[N][N2 - 1];
}

void main() { runSolution!(solve)(345); }
