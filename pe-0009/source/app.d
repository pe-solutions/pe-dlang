// Special Pythagorean Triplet
// https://projecteuler.net/problem=9

import std.typecons : tuple, Tuple;
import euler.common : runSolution;

enum PERIMETER = 1_000u;

Tuple!(uint, uint, uint) findTriplet() {
    foreach (uint a; 1 .. PERIMETER/3)
        foreach (uint b; a + 1 .. PERIMETER/2) {
            uint c = PERIMETER - a - b;
            if (a * a + b * b == c * c)
                return tuple(a, b, c);
        }
    return tuple(0u, 0u, 0u);
}

auto solve() {
    auto t = findTriplet();
    return t[0] * t[1] * t[2];
}

void main() { runSolution!(solve)(9); }
