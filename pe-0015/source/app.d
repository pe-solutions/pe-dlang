// Lattice Paths
// https://projecteuler.net/problem=15

import euler.common : runSolution;

auto solve() {
    import std.range : iota;
    import std.algorithm.iteration : reduce;
    alias countRoutes = (int n) => reduce!((a, b) => a * (n + b) / b)(1L, iota(1, n + 1));
    return countRoutes(20);
}

void main() { runSolution!(solve)(15); }
