// Right Triangles with Integer Coordinates
// https://projecteuler.net/problem=91

import std.range : iota;
import std.algorithm : cartesianProduct, count, filter;
import euler.common : runSolution;

bool isValidTuple(int k1, int k2, int l1, int l2) {
    return k1 * l2 != k2 * l1 &&
           (k1 * k1 + k2 * k2 == k1 * l1 + k2 * l2 ||
            l1 * l1 + l2 * l2 == k1 * l1 + k2 * l2 ||
            k1 * l1 + k2 * l2 == 0);
}

auto solve() {
    auto ranges = iota(0, 51);
    return cartesianProduct(ranges, ranges, ranges, ranges)
        .filter!(t => isValidTuple(t[0], t[1], t[2], t[3]))
        .count / 2;
}

void main() { runSolution!(solve)(91); }
