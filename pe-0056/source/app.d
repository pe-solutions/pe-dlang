// Powerful Digit Sum
// https://projecteuler.net/problem=56

import euler.common : runSolution;

auto solve() {
    import std.algorithm : cartesianProduct, map, maxElement, sum;
    import std.bigint : BigInt;
    import std.range : iota;
    import std.conv : to;
    return iota(1, 100)
        .cartesianProduct(iota(1, 100))
        .map!(ab => BigInt(ab[0]) ^^ ab[1])
        .map!(n => n.to!string.map!(c => c - '0').sum)
        .maxElement;
}

void main() { runSolution!(solve)(56); }
