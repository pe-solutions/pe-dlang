// Prime Summations
// https://projecteuler.net/problem=77

import euler.common : runSolution;

auto solve() {
    import euler.math : sieve;
    enum int limit  = 200;
    enum int target = 5_000;

    auto isPrime = sieve(limit);
    auto ways = new long[limit + 1];
    ways[0] = 1;

    foreach (p; 2 .. limit + 1) {
        if (!isPrime[p]) continue;
        foreach (n; p .. limit + 1)
            ways[n] += ways[n - p];
    }

    foreach (n; 2 .. limit + 1)
        if (ways[n] > target) return n;

    assert(false);
}

void main() { runSolution!(solve)(77); }
