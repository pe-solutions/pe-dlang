// Minimal Network
// https://projecteuler.net/problem=107

import euler.common : runSolution;

auto solve() {
    import std.string    : splitLines, split;
    import std.conv      : to;
    import std.algorithm : sort;

    struct Edge { int u, v, w; }
    Edge[] edges;
    int totalWeight;

    foreach (i, line; import("data/network.txt").splitLines) {
        foreach (j, tok; line.split(",")) {
            if (tok == "-") continue;
            immutable w = tok.to!int;
            if (j > i) { edges ~= Edge(cast(int)i, cast(int)j, w); totalWeight += w; }
        }
    }

    // Kruskal's MST via union-find with path halving and union by rank.
    int[40] parent, rnk;
    foreach (i; 0 .. 40) parent[i] = i;

    int find(int x) {
        while (parent[x] != x) { parent[x] = parent[parent[x]]; x = parent[x]; }
        return x;
    }
    bool unite(int a, int b) {
        a = find(a); b = find(b);
        if (a == b) return false;
        if (rnk[a] < rnk[b]) { int t = a; a = b; b = t; }
        parent[b] = a;
        if (rnk[a] == rnk[b]) ++rnk[a];
        return true;
    }

    edges.sort!((e1, e2) => e1.w < e2.w);

    int mstWeight;
    foreach (e; edges)
        if (unite(e.u, e.v)) mstWeight += e.w;

    return totalWeight - mstWeight;
}

void main() { runSolution!(solve)(107); }
