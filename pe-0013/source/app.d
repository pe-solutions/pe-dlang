// Large Sum
// https://projecteuler.net/problem=13

import std.bigint : BigInt;
import std.array : array;
import std.conv : text;
import std.string : splitLines;

import euler.common : runSolution;

enum numbers = splitLines(import("data/numbers.txt")).array;

enum answer = (() {
    BigInt sum = 0;

    foreach (n; numbers)
        sum += BigInt(n);

    return text(sum)[0 .. 10];
})();

auto solve() {
    return answer;
}

void main() {
    runSolution!(solve)(13);
}