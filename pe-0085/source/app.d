// Counting Rectangles
// https://projecteuler.net/problem=85

import std.math : sqrt;
import euler.common : runSolution;

auto solve() {
    enum long target = 2_000_000;
    long best = long.max;
    int answer = 0;

    for (int m = 1; ; ++m) {
        immutable long km = cast(long)m * (m + 1) / 2;
        if (km > target) break;
        // Solve n*(n+1)/2 ≈ target/km for n via quadratic formula, then check floor and ceil.
        immutable int n0 = cast(int)((-1.0 + sqrt(1.0 + 8.0 * target / km)) / 2.0);
        foreach (n; [n0, n0 + 1]) {
            if (n < 1) continue;
            immutable long count = km * (cast(long)n * (n + 1) / 2);
            immutable long diff = count > target ? count - target : target - count;
            if (diff < best) { best = diff; answer = m * n; }
        }
    }
    return answer;
}

void main() { runSolution!(solve)(85); }
