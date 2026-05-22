// Even Fibonacci Numbers
// https://projecteuler.net/problem=2

import euler.common : runSolution;

private static ulong genEvenFibonacci(R)(R state, size_t n) pure nothrow @nogc {
    return 4 * state[n-1] + state[n-2];
}

auto solve() {
    import std.range : recurrence;
    import std.algorithm : sum;
    import std.algorithm.searching : until;
    return recurrence!genEvenFibonacci(2uL, 8uL)
        .until!(n => n > 4_000_000uL)
        .sum;
}

void main() { runSolution!(solve)(2); }
