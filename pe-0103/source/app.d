// Special Subset Sums: Optimum
// https://projecteuler.net/problem=103

import euler.common : runSolution;

private bool isSpecial(int[] a) pure nothrow @nogc {
    immutable n = cast(int)a.length;
    // Property (ii): sum of k+1 smallest > sum of k largest; a sorted ascending.
    foreach (k; 1 .. (n - 1) / 2 + 1) {
        int lo = 0, hi = 0;
        foreach (i; 0 ..     k + 1) lo += a[i];
        foreach (i; n - k .. n    ) hi += a[i];
        if (lo <= hi) return false;
    }
    // Property (i): all 2^n − 1 non-empty subset sums are distinct
    bool[16_384] seen;
    for (int mask = 1; mask < (1 << n); mask++) {
        int s = 0;
        foreach (i; 0 .. n)
            if (mask & (1 << i)) s += a[i];
        if (seen[s]) return false;
        seen[s] = true;
    }
    return true;
}

auto solve() {
    import std.conv      : to;
    import std.algorithm : map;
    import std.array     : join;

    // n=6 optimum {11,17,20,22,23,24} → n=7 candidate: {a3} ∪ {ai + a3}
    // = {20} ∪ {31,37,40,42,43,44} = {20,31,37,40,42,43,44}
    enum int[7] cand = [20, 31, 37, 40, 42, 43, 44];

    int bestSum = int.max;
    int[7] best;
    int[7] a;

    foreach (d0; -3 .. 4) { a[0] = cand[0]+d0; if (a[0] <= 0)    continue;
    foreach (d1; -3 .. 4) { a[1] = cand[1]+d1; if (a[1] <= a[0]) continue;
    foreach (d2; -3 .. 4) { a[2] = cand[2]+d2; if (a[2] <= a[1]) continue;
    foreach (d3; -3 .. 4) { a[3] = cand[3]+d3; if (a[3] <= a[2]) continue;
    foreach (d4; -3 .. 4) { a[4] = cand[4]+d4; if (a[4] <= a[3]) continue;
    foreach (d5; -3 .. 4) { a[5] = cand[5]+d5; if (a[5] <= a[4]) continue;
    foreach (d6; -3 .. 4) { a[6] = cand[6]+d6; if (a[6] <= a[5]) continue;
        immutable s = a[0]+a[1]+a[2]+a[3]+a[4]+a[5]+a[6];
        if (s < bestSum && isSpecial(a[])) { bestSum = s; best = a; }
    }}}}}}}

    return best[].map!(x => x.to!string).join;
}

void main() { runSolution!(solve)(103); }
