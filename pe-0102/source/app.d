// Triangle Containment
// https://projecteuler.net/problem=102

import euler.common : runSolution;

// Origin is inside triangle iff the three signed sub-triangle areas share a sign.
// Signed area of (O, P1, P2) * 2 = x1*y2 - x2*y1.
private bool containsOrigin(int x1, int y1, int x2, int y2, int x3, int y3) pure nothrow @nogc {
    immutable s1 = x1 * y2 - x2 * y1;
    immutable s2 = x2 * y3 - x3 * y2;
    immutable s3 = x3 * y1 - x1 * y3;
    return (s1 > 0 && s2 > 0 && s3 > 0) || (s1 < 0 && s2 < 0 && s3 < 0);
}

auto solve() {
    import std.string : splitLines, split;
    import std.conv : to;
    int count = 0;
    foreach (line; import("data/triangles.txt").splitLines) {
        if (line.length == 0) continue;
        auto v = line.split(",");
        if (containsOrigin(v[0].to!int, v[1].to!int, v[2].to!int,
                           v[3].to!int, v[4].to!int, v[5].to!int))
            count++;
    }
    return count;
}

void main() { runSolution!(solve)(102); }
