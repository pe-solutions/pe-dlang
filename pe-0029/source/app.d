// Distinct Powers
// https://projecteuler.net/problem=29

import euler.common : runSolution;

// Smallest g >= 2 such that a = g^k for some k >= 1.
private int minBase(int a)
{
    import std.math : pow, round;
    foreach_reverse (k; 2 .. 7)
    {
        immutable g = cast(int) round(pow(cast(double) a, 1.0 / k));
        foreach (c; (g >= 3 ? g - 1 : 2) .. g + 2)
        {
            long p = 1;
            foreach (_; 0 .. k) p *= c;
            if (cast(int) p == a) return c;
        }
    }
    return a;
}

auto solve()
{
    // a^b == g^(k*b); track distinct (g, k*b) pairs in a flat bitmap.
    // k <= 6 (2^7 > 100), b <= 100  =>  max exponent = 600.
    bool[601][101] seen;
    int count = 0;

    foreach (a; 2 .. 101)
    {
        immutable g = minBase(a);
        int k = 1;
        for (long p = g; p < a; p *= g) ++k;
        foreach (b; 2 .. 101)
        {
            immutable e = k * b;
            if (!seen[g][e]) { seen[g][e] = true; ++count; }
        }
    }
    return count;
}

void main() { runSolution!(solve)(29); }
