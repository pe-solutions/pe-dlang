// Special Subset Sums: Meta-testing
// https://projecteuler.net/problem=106

import euler.common : runSolution;

private long binomial(int n, int k) pure nothrow @nogc {
    if (k > n - k) k = n - k;
    if (k < 0) return 0;
    long result = 1;
    foreach (i; 0 .. k)
        result = result * (n - i) / (i + 1);
    return result;
}

auto solve() {
    // A k-element pair {B,C} (disjoint, from n sorted elements) needs testing
    // iff sorted B and C are NOT element-wise consistently ordered.
    // Per selection of 2k elements, trivially-ordered pairs = Catalan(k)
    // = C(2k,k)/(k+1): the ballot sequences where B leads at every prefix.
    // Tests for size k: C(n,2k) × (C(2k,k)/2 − C(2k,k)/(k+1)).
    // (k=1 always contributes 0; exact integer divisions for all k.)
    enum int n = 12;
    long total = 0;
    foreach (k; 2 .. n / 2 + 1) {
        immutable c2k  = binomial(2 * k, k);
        immutable cn2k = binomial(n, 2 * k);
        total += cn2k * (c2k / 2 - c2k / (k + 1));
    }
    return total;
}

void main() { runSolution!(solve)(106); }
