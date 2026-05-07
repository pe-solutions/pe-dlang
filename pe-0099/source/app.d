// Largest Exponential
// https://projecteuler.net/problem=99

import std.algorithm : map, maxIndex;
import std.array    : array;
import std.conv     : to;
import std.math     : log;
import std.string   : splitLines, split;
import euler.common : runSolution;

auto solve() {
    // a^b > c^d  iff  b·log(a) > d·log(c)
    auto logValues = import("data/base_exp.txt").splitLines
        .map!((line) {
            auto p = line.split(",");
            return p[1].to!double * log(p[0].to!double);
        })
        .array;

    return logValues.maxIndex + 1;  // answer is 1-indexed line number
}

void main() { runSolution!(solve)(99); }
