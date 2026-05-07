// Largest Product in a Grid
// https://projecteuler.net/problem=11

import std.string : splitLines, split;
import std.conv : to;
import euler.common : runSolution;

// Grid parsed from file at compile time via CTFE.
static immutable int[20][20] g = () {
    int[20][20] result;
    foreach (r, line; import("data/grid_20x20.txt").splitLines)
        foreach (c, tok; line.split)
            result[r][c] = tok.to!int;
    return result;
}();

auto solve() {
    // Four direction vectors: right, down, down-right, down-left.
    // Reverse directions are redundant since they yield the same product.
    immutable int[2][4] dirs = [[0,1],[1,0],[1,1],[1,-1]];

    int best = 0;
    foreach (r; 0 .. 20) {
        foreach (c; 0 .. 20) {
            foreach (d; dirs) {
                immutable int er = r + 3*d[0];
                immutable int ec = c + 3*d[1];
                if (er < 0 || er >= 20 || ec < 0 || ec >= 20) continue;
                int p = 1;
                foreach (k; 0 .. 4) {
                    p *= g[r + k*d[0]][c + k*d[1]];
                }
                if (p > best) best = p;
            }
        }
    }

    return best;
}

void main() { runSolution!(solve)(11); }
