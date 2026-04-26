// Powerful Digit Counts
// https://projecteuler.net/problem=63

import std.math : floor, log10;
import euler.common : runSolution;

auto solve() {
    int totalCount = 0;
    foreach (i; 1 .. 10) {
        real log_i = log10(cast(real)i);
        totalCount += cast(int) floor(1.0 / (1.0 - log_i));
    }
    return totalCount;
}

void main() { runSolution!(solve, 63)(); }
