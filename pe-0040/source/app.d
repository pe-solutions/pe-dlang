// Champernowne's Constant
// https://projecteuler.net/problem=40

import std.range : array, iota;
import std.algorithm : joiner, map;
import std.conv : to;
import euler.common : runSolution;

auto solve() {
    auto c = iota(1, 250_000+1)
        .map!(x => to!string(x).map!(ch => ch.to!int - '0').array)
        .joiner
        .array;
    return c[0] * c[9] * c[99] * c[999] * c[9_999] * c[99_999] * c[999_999];
}

void main() { runSolution!(solve)(40); }
