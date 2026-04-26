// Largest Prime Factor
// https://projecteuler.net/problem=3

import euler.math : largestPrimeFactor;
import euler.common : runSolution;

auto solve() { return 600_851_475_143.largestPrimeFactor; }

void main() { runSolution!(solve, 3)(); }
