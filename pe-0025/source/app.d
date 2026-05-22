// 1000-digit Fibonacci Number
// https://projecteuler.net/problem=25

import euler.common : runSolution;

auto solve() {
    import euler.math : fibFirstNDigits; return fibFirstNDigits(1_000); }

void main() { runSolution!(solve)(25); }
