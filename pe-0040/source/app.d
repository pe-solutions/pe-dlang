// Champernowne's Constant
// https://projecteuler.net/problem=40

import euler.common : runSolution;

auto solve() {
    import std.range : array, iota;
    import std.algorithm : joiner, map, fold;
    import std.conv : to;
    enum limit = 250_000;
    enum int[7] idx = [0, 9, 99, 999, 9_999, 99_999, 999_999];
    auto c = iota(1, limit + 1)
        .map!(x => to!string(x).map!(ch => ch.to!int - '0').array)
        .joiner
        .array;
    return idx[].map!(i => c[i]).fold!((a, b) => a * b);
}

void main() { runSolution!(solve)(40); }
