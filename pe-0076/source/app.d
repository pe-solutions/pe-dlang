// Counting Summations
// https://projecteuler.net/problem=76

import euler.common : runSolution;

size_t computePartitions(int n) {
    auto partitions = new size_t[n + 1];
    partitions[0] = 1;
    foreach (i; 1 .. n + 1) {
        foreach (j; i .. n + 1) {
            partitions[j] += partitions[j - i];
        }
    }
    return partitions[n];
}

auto solve() {
    return computePartitions(100) - 1;
}

void main() { runSolution!(solve, 76)(); }
