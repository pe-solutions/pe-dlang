// Reciprocal Cycles
// https://projecteuler.net/problem=26

import std.range     : iota;
import std.algorithm : maxElement;
import euler.common  : runSolution;

private int cycleLength(int d)
{
    int[1000] seen = -1;
    int r = 1, p = 0;
    while (r != 0)
    {
        if (seen[r] >= 0) return p - seen[r];
        seen[r] = p++;
        r = r * 10 % d;
    }
    return 0;
}

auto solve()
{
    return iota(2, 1000).maxElement!cycleLength;
}

void main() { runSolution!(solve)(26); }
