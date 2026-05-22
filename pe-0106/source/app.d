// Special Subset Sums: Meta-testing
// https://projecteuler.net/problem=106

import euler.common : runSolution;

// Approach 1 — standard Catalan filter (default)
// For each 2k-element selection, trivially-ordered unordered pairs = Catalan(k)
// = C(2k,k)/(k+1). Tests for size k: C(n,2k) × (C(2k,k)/2 − Catalan(k)).
private long solveCatalan() pure nothrow @nogc {
    import euler.math : binomial;
    enum int n = 12;
    long total = 0;
    foreach (k; 2 .. n / 2 + 1) {
        immutable c2k  = binomial(2 * k, k);
        immutable cn2k = binomial(n, 2 * k);
        total += cn2k * (c2k / 2 - c2k / (k + 1));
    }
    return total;
}

// Approach 2 — ballot-sequence identity
// Catalan(k) = C(2k+1,k)/(2k+1): ballot sequences of length 2k+1 with k wins.
// A(2k) = C(2k,k)/2 − C(2k+1,k)/(2k+1); total = Σ C(n,2k)·A(2k).
private long solveBallot() pure nothrow @nogc {
    import euler.math : binomial;
    enum int n = 12;
    long total = 0;
    for (int i = 4; i <= n; i += 2) {
        immutable k = i / 2;
        immutable a = binomial(i, k) / 2 - binomial(i + 1, k) / (i + 1);
        total += a * binomial(n, i);
    }
    return total;
}

auto solve() {
    immutable result = solveCatalan();
    assert(solveBallot() == result, "solveBallot disagrees");  // stripped by -release
    return result;
}

void main() { runSolution!(solve)(106); }
