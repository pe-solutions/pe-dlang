// Totient Maximum
// https://projecteuler.net/problem=69

import euler.common : runSolution;

// n/φ(n) = ∏ p/(p−1) over distinct prime factors; maximised by the largest
// primorial ≤ limit (product of the first k primes that still fits).
auto solve() {
    import euler.math : nthPrime;
    enum int limit = 1_000_000;
    int product = 1;
    for (int k = 1; ; ++k) {
        immutable int p = nthPrime(k);
        if (product * p > limit) return product;
        product *= p;
    }
}

void main() { runSolution!(solve)(69); }
