// Rectangles in Cross-hatched Grids
// https://projecteuler.net/problem=147

import euler.common : runSolution;

auto solve() {
    import std.algorithm.comparison : min, max;

    // Axis-aligned: C(m+1,2)*C(n+1,2) = m(m+1)n(n+1)/4.
    //
    // Diagonal (45°-tilted): NE lines y−x=a,b and NW lines y+x=c,d.
    // Four corners must lie in [0,m]×[0,n], giving:
    //   lo_c = max(1, b, −a)
    //   up_c = min(m+n−1, 2m+a, 2n−b)  (for h=0; decreases by 1 per unit of h)
    // Summing over h=1..K−1 yields K*(K−1)/2, K = up_c − lo_c + 1.

    long total = 0;

    for (int m = 1; m <= 47; ++m)
        for (int n = 1; n <= 43; ++n) {
            total += cast(long) m * (m + 1) * n * (n + 1) / 4;
            for (int a = -(m - 1); a <= n - 1; ++a)
                for (int b = a + 1; b <= n - 1; ++b) {
                    immutable int lo = max(1, b, -a);
                    immutable int up = min(m + n - 1, 2 * m + a, 2 * n - b);
                    immutable int K  = up - lo + 1;
                    if (K >= 2) total += cast(long) K * (K - 1) / 2;
                }
        }

    return total;
}

void main() { runSolution!(solve)(147); }
