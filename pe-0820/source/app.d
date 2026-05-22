// Nth Digit of Reciprocals
// https://projecteuler.net/problem=820

import euler.common : runSolution;

auto solve() {
    import std.range : iota;
    import std.math : powmod;
    import std.algorithm : map, sum;
    ulong n = 10_000_000;
    return iota(1UL, n + 1).map!(k => powmod(10UL, n, 10UL * k) / k).sum;
}

void main() { runSolution!(solve)(820); }
