// Hybrid Integers
// https://projecteuler.net/problem=800

import std.math : pow;
import std.range : iota;
import std.algorithm : filter;
import std.array : array;
import euler.math : sieve;
import euler.common : runSolution;

bool isValid(double p, double q, double b, double e) {
    return pow(p, q / e) * pow(q, p / e) <= b;
}

int count_hybrid_integers(int base, int exponent) {
    auto isPrime = sieve(16_000_000);
    auto primes = iota(2, 16_000_001).filter!(i => isPrime[i]).array;
    int count = 0;
    for (int p = 0; p + 1 < primes.length; ++p) {
        for (int q = p + 1; q < primes.length; ++q) {
            if (isValid(primes[p], primes[q], base, exponent)) {
                count += 1;
            } else {
                break;
            }
        }
        if (!isValid(primes[p], 2.0, base, exponent)) break;
    }
    return count;
}

auto solve() {
    return count_hybrid_integers(800_800, 800_800);
}

void main() { runSolution!(solve, 800)(); }
