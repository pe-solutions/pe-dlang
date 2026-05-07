// Largest Product in a Series
// https://projecteuler.net/problem=8

import std.range : iota;
import std.algorithm : map, maxElement, reduce;
import std.array : array, join;
import std.string : splitLines;
import std.conv : to;
import euler.common : runSolution;

enum CONSECUTIVEDIGITS = 13;

// 1000-digit number embedded at compile time; newlines stripped via CTFE.
enum string data = import("data/1000digits.txt").splitLines.join;

auto solve() {
    auto digits = data.map!(c => cast(long)(c - '0')).array;
    return iota(0, digits.length - CONSECUTIVEDIGITS)
           .map!(i => digits[i .. i + CONSECUTIVEDIGITS].reduce!"a * b"())
           .maxElement;
}

void main() { runSolution!(solve)(8); }
