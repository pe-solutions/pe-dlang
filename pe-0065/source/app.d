// Convergents of e
// https://projecteuler.net/problem=65

import std.algorithm : map, sum;
import std.bigint : BigInt;
import std.conv : to;
import euler.common : runSolution;

auto solve() {
    enum int n = 100;
    BigInt prev2 = BigInt(1);
    BigInt prev1 = BigInt(2);
    foreach (k; 2 .. n + 1) {
        immutable long a = (k % 3 == 0) ? 2 * k / 3 : 1;
        BigInt curr = prev1 * a + prev2;
        prev2 = prev1;
        prev1 = curr;
    }
    return prev1.to!string.map!(c => c - '0').sum;
}

void main() { runSolution!(solve)(65); }
