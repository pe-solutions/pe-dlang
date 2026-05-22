// Cyclical Figurate Numbers
// https://projecteuler.net/problem=61

import euler.common : runSolution;

private int first2(int n) pure nothrow @nogc { return n / 100; }
private int last2(int n) pure nothrow @nogc { return n % 100; }

// General k-gonal formula: P(k,n) = n * ((k−2)n − (k−4)) / 2
private int[] polySet(int k) {
    int[] result;
    for (int n = 1; ; ++n) {
        int v = n * ((k - 2) * n - (k - 4)) / 2;
        if (v > 9999) break;
        if (v >= 1000 && last2(v) >= 10)
            result ~= v;
    }
    return result;
}

auto solve() {
    int[][6] poly;
    foreach (i; 0 .. 6)
        poly[i] = polySet(i + 3);

    // lookup[type][prefix] — 4-digit k-gonal numbers indexed by their first-two-digit prefix
    int[][100][6] lookup;
    foreach (type; 0 .. 6)
        foreach (num; poly[type])
            lookup[type][first2(num)] ~= num;

    int[6] chain;
    bool found;

    void dfs(int depth, int tail, int used, int start) {
        if (depth == 6) {
            found = (tail == start);
            return;
        }
        foreach (type; 0 .. 6) {
            if (used >> type & 1) continue;
            foreach (num; lookup[type][tail]) {
                chain[depth] = num;
                dfs(depth + 1, last2(num), used | (1 << type), start);
                if (found) return;
            }
        }
    }

    // The cycle always contains a triangle number; fix it as the chain head
    foreach (start; poly[0]) {
        chain[0] = start;
        dfs(1, last2(start), 1, first2(start));
        if (found) break;
    }

    import std.algorithm : sum;
    return chain[].sum;
}

void main() { runSolution!(solve)(61); }
