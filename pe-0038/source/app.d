// Pandigital Multiples
// https://projecteuler.net/problem=38

import std.array : array;
import std.algorithm : sort;
import std.conv : text;
import euler.common : runSolution;

bool isPandigitalConcatenation(int num) {
    auto s = text(num);
    return s.length == 9 && text(s.array.sort) == "123456789";
}

auto solve() {
    const int MAX_INDEX = 9_876;
    const MULTIPLIER = 10^^5 + 2;
    for (int index = MAX_INDEX; index > 0; index--) {
        int candidate = index * MULTIPLIER;
        if (isPandigitalConcatenation(candidate))
            return candidate;
    }
    return 0;
}

void main() { runSolution!(solve)(38); }
