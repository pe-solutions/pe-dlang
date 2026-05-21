// Combinatoric Selections
// https://projecteuler.net/problem=53

import std.algorithm : min;
import euler.common  : runSolution;

auto solve()
{
    // Cap at cap to stay in int range; values ≥ cap count as "> 1 000 000".
    enum int cap = 1_000_001;
    int[101] row;
    row[0] = 1;
    int count = 0;

    foreach (n; 1 .. 101)
    {
        // Right-to-left update keeps row[r-1] unmodified for this iteration.
        foreach_reverse (r; 1 .. n + 1)
            row[r] = min(row[r] + row[r - 1], cap);
        foreach (r; 0 .. n + 1)
            if (row[r] >= cap)
                ++count;
    }

    return count;
}

void main() { runSolution!(solve)(53); }
