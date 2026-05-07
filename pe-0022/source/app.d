// Names Scores
// https://projecteuler.net/problem=22

import std.algorithm : sort, map, sum;
import std.array     : replace, split;
import std.range     : enumerate;
import euler.common  : runSolution;

auto solve() {
    auto names = import("data/names.txt").replace(`"`, "").split(",");
    names.sort();
    return names
        .enumerate(1)
        .map!(t => cast(long) t.index * t.value.map!(c => c - 'A' + 1).sum(0))
        .sum(0L);
}

void main() { runSolution!(solve)(22); }
