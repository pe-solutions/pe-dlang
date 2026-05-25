// Counting Summations
// https://projecteuler.net/problem=76

import euler.common : runSolution;

auto solve() {
    import euler.math : partitions;
    return partitions(100) - 1;
}

void main() { runSolution!(solve)(76); }
