// Special Subset Sums: Testing
// https://projecteuler.net/problem=105

import euler.common : runSolution;

private bool isSpecial(int[] a) pure nothrow @nogc {
    immutable n = cast(int)a.length;
    // Property (ii): sum of k+1 smallest > sum of k largest; a sorted ascending.
    // Valid range: k+1+k ≤ n ⟹ k ≤ (n-1)/2.
    foreach (k; 1 .. (n - 1) / 2 + 1) {
        int lo = 0, hi = 0;
        foreach (i; 0 ..     k + 1) lo += a[i];
        foreach (i; n - k .. n    ) hi += a[i];
        if (lo <= hi) return false;
    }
    // Property (i): all 2^n − 1 non-empty subset sums are distinct.
    // Max sum ≤ 12 × 1287 = 15444, safely within bool[16384].
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
    import std.string    : splitLines, strip;
    import std.algorithm : map, sum, sort;
    import std.conv      : to;
    import std.array     : split, array;

    int total = 0;
    foreach (line; import("data/sets.txt").splitLines) {
        if (line.strip.length == 0) continue;
        auto a = line.split(",").map!(s => s.strip.to!int).array;
        a.sort();
        if (isSpecial(a)) total += a.sum;
    }
    return total;
}

void main() { runSolution!(solve)(105); }
