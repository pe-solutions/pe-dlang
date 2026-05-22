// Multiples of 3 or 5
// https://projecteuler.net/problem=1

import euler.common : runSolution;

auto solve() {
    import std.range : iota;
    import std.algorithm : any, filter, sum;
    return iota(1, 1_000)
        .filter!(n => [3, 5].any!(m => n % m == 0))
        .sum;
}

void main() { runSolution!(solve)(1); }
