// Powers with Trailing Digits
// https://projecteuler.net/problem=455

import euler.common : runSolution;

auto solve() {
    import std.math : powmod;
    enum ulong limit   = 1_000_000;
    enum ulong modulus = 1_000_000_000;

    ulong totalSum = 0;

    for (ulong n = 2; n <= limit; ++n) {
        if (n % 10 == 0) continue;

        ulong current, next;
        for (current = n; ; current = next) {
            next = powmod(n, current, modulus);
            if (next == current) break;
        }
        totalSum += current;
    }

    return totalSum;
}

void main() { runSolution!(solve)(455); }
