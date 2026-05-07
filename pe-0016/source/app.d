// Power Digit Sum
// https://projecteuler.net/problem=16

import std.bigint    : BigInt;
import std.conv      : to;
import std.algorithm : map, sum;
import euler.common  : runSolution;

auto solve() {
    return (BigInt(2) ^^ 1000).to!string.map!(c => c - '0').sum(0u);
}

void main() { runSolution!(solve)(16); }
