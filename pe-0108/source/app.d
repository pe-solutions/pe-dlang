// Diophantine Reciprocals I
// https://projecteuler.net/problem=108

import euler.common : runSolution;

auto solve() {
    // 1/x + 1/y = 1/n  ⟺  (x−n)(y−n) = n².
    // Unordered solution pairs biject with divisors d ≤ n of n²,
    // giving count = (τ(n²) + 1) / 2.  τ(n²) is always odd.
    // Find smallest n with count > 1000, i.e. τ(n²) > 1999.
    for (int n = 1; ; n++) {
        int m = n, tau = 1;
        for (int p = 2; p * p <= m; p++) {
            if (m % p == 0) {
                int e = 0;
                while (m % p == 0) { m /= p; e++; }
                tau *= 2 * e + 1;
            }
        }
        if (m > 1) tau *= 3;  // remaining prime factor: exponent 1 → 2·1+1 = 3
        if (tau > 1999) return n;
    }
    assert(false);
}

void main() { runSolution!(solve)(108); }
