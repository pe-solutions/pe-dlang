// Amicable Numbers
// https://projecteuler.net/problem=21

import std.algorithm : filter, sum;
import std.range     : iota;
import euler.common  : runSolution;

auto solve() {
    enum int N = 10_000;

    auto spd = new int[N];
    foreach (d; 1 .. N)
        for (int m = 2 * d; m < N; m += d)
            spd[m] += d;

    return iota(2, N)
        .filter!(a => spd[a] != a && spd[a] < N && spd[spd[a]] == a)
        .sum;
}

void main() { runSolution!(solve)(21); }
