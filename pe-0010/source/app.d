// Summation of Primes
// https://projecteuler.net/problem=10

import std.range : iota;
import std.algorithm : filter, sum;
import euler.math : isPrime;
import euler.common : runSolution;

auto solve() {
    return iota(2, 2_000_000).filter!(isPrime).sum(0L);
}

void main() { runSolution!(solve)(10); }
