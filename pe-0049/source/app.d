// Prime Permutations
// https://projecteuler.net/problem=49

import std.algorithm : equal, sort;
import std.array : array;
import std.conv : to;
import euler.math : isPrime;
import euler.common : runSolution;

bool ispermutation(ulong a, ulong b) {
    return equal(to!string(a).array.sort, to!string(b).array.sort);
}

auto solve() {
    const ulong STEP = 3330;
    for (ulong a = 1488; a <= STEP + 1; a++) {
        ulong b = a + STEP;
        ulong c = b + STEP;
        if (isPrime(a) && isPrime(b) && isPrime(c) && ispermutation(a, b) && ispermutation(b, c))
            return 10^^(2 * 4) * a + 10^^4 * b + c;
    }
    return 0uL;
}

void main() { runSolution!(solve)(49); }
