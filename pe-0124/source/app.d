// Ordered Radicals
// https://projecteuler.net/problem=124

import euler.common : runSolution;

auto solve() {
    import std.algorithm : sort;
    import std.range     : iota;
    import std.array     : array;

    enum int N = 100_000;
    enum int K = 10_000;

    // Sieve-style: for each prime p multiply rad[m] by p for every multiple m.
    int[N + 1] rad;
    foreach (ref r; rad) r = 1;
    foreach (p; 2 .. N + 1) {
        if (rad[p] == 1) {                      // p is prime (unvisited)
            for (int m = p; m <= N; m += p)
                rad[m] *= p;
        }
    }

    auto ns = iota(1, N + 1).array;
    sort!((a, b) => rad[a] != rad[b] ? rad[a] < rad[b] : a < b)(ns);
    return ns[K - 1];
}

void main() { runSolution!(solve)(124); }
