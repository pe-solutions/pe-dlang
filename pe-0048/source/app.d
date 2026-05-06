// Self Powers
// https://projecteuler.net/problem=48

import std.bigint : BigInt, powmod;
import std.range : iota;
import std.algorithm : map, sum;
import euler.common : runSolution;

auto solve() {
    return powmod(iota(1, 1001).map!(i => BigInt(i) ^^ i).sum, 1.BigInt, 10.BigInt ^^ 10);
}

void main() { runSolution!(solve)(48); }
