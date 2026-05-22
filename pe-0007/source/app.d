// 10001st Prime
// https://projecteuler.net/problem=7

import euler.common : runSolution;

auto solve() {
    import euler.math : nthPrime; return nthPrime(10_001); }

void main() { runSolution!(solve)(7); }
