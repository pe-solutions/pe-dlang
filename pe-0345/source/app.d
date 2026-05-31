// Matrix Sum
// https://projecteuler.net/problem=345

import euler.common : runSolution;
import euler.optim : AssignmentSolver;

enum N = 15;

// Matrix parsed from file at compile time via CTFE.
static immutable int[N][N] matrix = () {
    import std.string : splitLines, split;
    import std.conv : to;
    int[N][N] result;
    foreach (r, line; import("data/matrix_15x15.txt").splitLines)
        foreach (c, tok; line.split)
            result[r][c] = tok.to!int;
    return result;
}();

auto solve() {
    auto solver = AssignmentSolver!(int, N)(matrix);
    return solver.solveMax();
}

void main() { runSolution!(solve)(345); }
