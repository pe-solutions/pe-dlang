// Investigating Progressive Numbers
// https://projecteuler.net/problem=141

import euler.common : runSolution;

// n = d·Q + R (0 < R < Q < d) with R,Q,d in geometric progression Q² = R·d.
// Parametrise: R = c·t², Q = c·s·t, d = c·s² with gcd(s,t) = 1 and s > t ≥ 1
// gives n = c·t·(c·s³ + t).  Iterate s,t,c, collect square values, deduplicate.
auto solve() {
    import std.algorithm : sort;
    import std.math : sqrt;
    import std.numeric : gcd;

    enum long limit = 1_000_000_000_000L;

    long[] hits;
    for (long s = 2; s * s * s < limit; ++s) {
        immutable long s3 = s * s * s;
        for (long t = 1; t < s; ++t) {
            if (t * (s3 + t) >= limit) break;
            if (gcd(s, t) != 1) continue;
            for (long c = 1; ; ++c) {
                immutable long n = c * t * (c * s3 + t);
                if (n >= limit) break;
                switch (n & 15) {
                    case 0, 1, 4, 9: break;
                    default: continue;
                }
                long sq = cast(long) sqrt(cast(double) n);
                while (sq * sq > n) --sq;
                while ((sq + 1) * (sq + 1) <= n) ++sq;
                if (sq * sq == n) hits ~= n;
            }
        }
    }

    sort(hits);
    long result = 0;
    long prev = -1;
    foreach (h; hits) {
        if (h != prev) { result += h; prev = h; }
    }
    return result;
}

void main() { runSolution!(solve)(141); }
