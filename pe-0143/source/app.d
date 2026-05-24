// Investigating the Torricelli Point of a Triangle
// https://projecteuler.net/problem=143

import euler.common : runSolution;

// x²+xy+y² = z² iff (x,y) = k*(m²−n², 2mn+n²) for gcd(m,n)=1, m>n>0, m≢n (mod 3).
// A valid triple (p,q,r) requires all three pairings to be good pairs.
auto solve() {
    import std.numeric : gcd;

    enum int LIMIT = 120_000;

    bool[long] pairSet;
    int[][]    partners = new int[][](LIMIT);

    void addPair(int a, int b) {
        if (a > b) { int t = a; a = b; b = t; }
        if (a + b >= LIMIT) return;
        immutable long key = cast(long) a * LIMIT + b;
        if (key in pairSet) return;
        pairSet[key] = true;
        partners[a] ~= b;
        partners[b] ~= a;
    }

    for (int m = 2; m * (m + 2) < LIMIT; ++m)
        for (int n = 1; n < m; ++n) {
            if (gcd(m, n) != 1 || (m - n) % 3 == 0) continue;
            immutable int a0 = m * m - n * n;
            immutable int b0 = 2 * m * n + n * n;
            for (int k = 1; k * (a0 + b0) < LIMIT; ++k)
                addPair(k * a0, k * b0);
        }

    bool[int] seenSums;

    // For each q, iterate small partners p<q and large partners r>q;
    // check if (p,r) is also a good pair. Each triple counted once (q is middle).
    for (int q = 1; q < LIMIT; ++q) {
        if (partners[q].length < 2) continue;
        foreach (p; partners[q]) {
            if (p >= q) continue;
            foreach (r; partners[q]) {
                if (r <= q) continue;
                immutable int s = p + q + r;
                if (s > LIMIT || s in seenSums) continue;
                if (cast(long) p * LIMIT + r in pairSet)
                    seenSums[s] = true;
            }
        }
    }

    long result = 0;
    foreach (s, _; seenSums)
        result += s;
    return result;
}

void main() { runSolution!(solve)(143); }
