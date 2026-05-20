// Reciprocal Cycles
// https://projecteuler.net/problem=26

import std.range     : iota;
import std.algorithm : maxElement;
import euler.common  : runSolution;

// Length of the repeating cycle in 1/d: simulate long division,
// return the step count between the first repeated remainder.
private int cycleLength(int d) {
    int[1000] seen = -1;
    for (int r = 1, p = 0; r != 0; r = r * 10 % d, ++p) {
        if (seen[r] >= 0) return p - seen[r];
        seen[r] = p;
    }
    return 0;
}

auto solve()
{
    return iota(2, 1000).maxElement!cycleLength;
}

void main() { runSolution!(solve)(26); }
