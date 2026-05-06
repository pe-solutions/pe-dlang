// Factorial Digit Sum
// https://projecteuler.net/problem=20

import euler.common : runSolution;

auto solve() {
    import std.range : iota;
    import std.bigint : BigInt;
    import std.conv : to;
    import std.algorithm : map, reduce, sum;
    return reduce!"a*b"(iota(1, 100+1).map!BigInt)
        .to!string
        .map!(c => c - '0')
        .sum(0u);
}

void main() { runSolution!(solve)(20); }
