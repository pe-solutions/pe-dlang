// Lexicographic Permutations
// https://projecteuler.net/problem=24

import std.algorithm : map, nextPermutation;
import std.array     : join;
import std.conv      : to;
import euler.common  : runSolution;

auto solve()
{
    enum int target = 999_999;  // advance 999_999 times from permutation #1 to reach #1_000_000
    auto digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    foreach (_; 0 .. target)
        digits.nextPermutation();
    return digits.map!(d => d.to!string).join;
}

void main() { runSolution!(solve)(24); }
