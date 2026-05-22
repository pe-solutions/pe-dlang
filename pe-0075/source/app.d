// Singular Integer Right Triangles
// https://projecteuler.net/problem=75

import euler.common : runSolution;

auto solve() {
    import std.numeric : gcd;
    enum int limit = 1_500_000;
    auto cnt = new ubyte[limit + 1];

    // Euclid's formula: primitive triple perimeter = 2m(m+n),
    // m > n > 0, gcd(m,n) = 1, opposite parity (n starts at 1+m%2, step 2).
    for (int m = 2; 2 * m * (m + 1) <= limit; ++m) {
        for (int n = 1 + (m & 1); n < m; n += 2) {
            if (gcd(m, n) != 1) continue;
            immutable int p = 2 * m * (m + n);
            for (int k = p; k <= limit; k += p)
                if (cnt[k] < 2) ++cnt[k];
        }
    }

    int answer = 0;
    foreach (c; cnt[1 .. limit + 1])
        if (c == 1) ++answer;
    return answer;
}

void main() { runSolution!(solve)(75); }
