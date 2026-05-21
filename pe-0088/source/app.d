// Product-sum Numbers
// https://projecteuler.net/problem=88

import euler.common : runSolution;

auto solve() {
    enum int K     = 12_000;
    enum int limit = 2 * K;  // 2k is always achievable: {2,k} + (k-2) ones

    int[K + 1] minPS;
    foreach (k; 2 .. K + 1) minPS[k] = 2 * k;

    // For each factorisation of n into s factors (≥2) summing to sumF,
    // the corresponding k = (s+1) + n - (sumF+rem), where rem is the last factor.
    void dfs(int n, int rem, int minF, int s, int sumF) {
        immutable int k = (s + 1) + n - (sumF + rem);
        if (k >= 2 && k <= K && n < minPS[k]) minPS[k] = n;
        for (int f = minF; f * f <= rem; ++f)
            if (rem % f == 0) dfs(n, rem / f, f, s + 1, sumF + f);
    }

    foreach (n; 2 .. limit + 1) dfs(n, n, 2, 0, 0);

    bool[limit + 1] counted;
    int total = 0;
    foreach (k; 2 .. K + 1)
        if (!counted[minPS[k]]) { counted[minPS[k]] = true; total += minPS[k]; }
    return total;
}

void main() { runSolution!(solve)(88); }
