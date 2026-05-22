// Square Root Convergents
// https://projecteuler.net/problem=57

import euler.common : runSolution;

auto solve()
{
    import std.bigint : BigInt;
    // Convergents of √2 = [1; 2,2,2,...]: n_{k+1} = n_k + 2·d_k, d_{k+1} = n_k + d_k.
    BigInt n = 1, d = 1;
    // tn/td = smallest power of 10 exceeding n/d; tn > td iff n has more digits than d.
    BigInt tn = 10, td = 10;
    int hits = 0;

    foreach (_; 0 .. 1000)
    {
        BigInt nn = n + d + d;
        d = n + d;
        n = nn;
        while (n >= tn) tn *= 10;
        while (d >= td) td *= 10;
        if (tn > td) ++hits;
    }

    return hits;
}

void main() { runSolution!(solve)(57); }
