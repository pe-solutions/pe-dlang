// Sum Square Difference
// https://projecteuler.net/problem=6

import std.range : iota;
import std.algorithm : map, sum;
import euler.common : runSolution;

auto solve() {
    return iota(1, 100+1).sum ^^ 2 - iota(1, 100+1).map!(a => a ^^ 2).sum;
}

void main() { runSolution!(solve)(6); }
