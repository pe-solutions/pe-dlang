// Largest Prime Factor
// https://projecteuler.net/problem=3

import euler.common : runSolution;

auto solve() {
    import euler.math : largestPrimeFactor; return 600_851_475_143.largestPrimeFactor; }

void main() { runSolution!(solve)(3); }
