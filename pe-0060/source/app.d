// Prime Pair Sets
// https://projecteuler.net/problem=60

import std.conv : to, ConvOverflowException;
import std.algorithm : filter, sum;
import euler.math : isPrime, sieve;
import euler.common : runSolution;

// Evaluated at compile time via CTFE; primes baked into binary, zero runtime cost.
static immutable ulong[] primes = () {
    auto s = sieve(9999);
    ulong[] result;
    foreach (i, p; s)
        if (p && i >= 2) result ~= cast(ulong) i;
    return result;
}();

bool checkPair(ulong x, ulong y) {
    auto xy = to!string(x) ~ to!string(y).dup;
    auto yx = to!string(y) ~ to!string(x).dup;

    try {
        return isPrime(xy.to!ulong) && isPrime(yx.to!ulong);
    } catch (ConvOverflowException e) {
        return false;  // concatenated digits can exceed ulong.max
    }
}

auto solve() {
    foreach (a; primes) {
        auto m = primes.filter!(b => b > a && checkPair(a, b));
        foreach (b; m) {
            auto n = m.filter!(c => c > b && checkPair(b, c));
            foreach (c; n) {
                auto o = n.filter!(d => d > c && checkPair(c, d));
                foreach (d; o) {
                    auto p = o.filter!(e => e > d && checkPair(d, e));
                    foreach (e; p) {
                        return [a, b, c, d, e].sum;
                    }
                }
            }
        }
    }

    return 0uL;
}

void main() { runSolution!(solve)(60); }
