// abc-hits
// https://projecteuler.net/problem=127

import euler.common : runSolution;

auto solve() {
    import std.algorithm : sort;
    import std.numeric   : gcd;

    enum int N = 120_000;

    // Sieve-style rad(n) = product of distinct prime factors.
    int[N] rad;
    foreach (ref r; rad) r = 1;
    foreach (p; 2 .. N) {
        if (rad[p] == 1)
            for (int m = p; m < N; m += p)
                rad[m] *= p;
    }

    // Sorting by rad lets us break the inner loop as soon as rad(a)·rad(c) ≥ c,
    // since all subsequent a' in sorted order have rad(a') ≥ rad(a).
    int[] sortedA = new int[](N - 1);
    foreach (i; 0 .. N - 1) sortedA[i] = i + 1;
    sort!((x, y) => rad[x] < rad[y])(sortedA);

    long sum = 0;
    for (int c = 3; c < N; c++) {
        immutable int rc = rad[c];
        if (rc == c) continue;  // squarefree: rad(a)·rad(b)·c ≥ c, impossible
        foreach (a; sortedA) {
            immutable int ra = rad[a];
            if (cast(long)ra * rc >= c) break;  // sorted order: all later a' also fail
            if (2 * a >= c) continue;           // need a < b = c − a
            immutable int b = c - a;
            if (cast(long)ra * rad[b] * rc >= c) continue;
            if (gcd(a, b) != 1) continue;
            sum += c;
        }
    }
    return sum;
}

void main() { runSolution!(solve)(127); }
