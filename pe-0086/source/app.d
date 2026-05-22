// Cuboid Route
// https://projecteuler.net/problem=86

import euler.common : runSolution;

auto solve() {
    import euler.math : isPerfectSquare;
    // For a ≤ b ≤ c the shortest surface path is √((a+b)²+c²).
    // Fix c and iterate over s = a+b in [2, 2c].  For each s where s²+c² is a
    // perfect square, the valid (a,b) pairs satisfy a ≤ b ≤ c and a+b = s, so
    // a ∈ [max(1, s−c), s/2].
    enum int target = 1_000_000;
    long count = 0;

    for (int c = 1; ; ++c) {
        foreach (s; 2 .. 2 * c + 1) {
            if (!isPerfectSquare(s * s + c * c)) continue;
            immutable int lo = s > c ? s - c : 1;
            immutable int hi = s / 2;
            if (hi >= lo) count += hi - lo + 1;
        }
        if (count > target) return c;
    }
    assert(false);
}

void main() { runSolution!(solve)(86); }
