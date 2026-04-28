// 10001st Prime
// https://projecteuler.net/problem=7

import euler.math : nthPrime;
import euler.common : runSolution;

auto solve() { return nthPrime(10_001); }

void main() { runSolution!(solve, 7)(); }
