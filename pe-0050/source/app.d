// Consecutive Prime Sum
// https://projecteuler.net/problem=50

import std.range : iota;
import std.algorithm : filter;
import std.array : array;
import euler.math : isPrime;
import euler.common : runSolution;

auto solve() {
    const long LIMIT = 1_000_000L;
    auto primes = iota(2L, LIMIT).filter!(isPrime).array;
    long maxSum = 0;
    long maxLength = 0;
    for (long i = 0; i < primes.length; i++) {
        long sum = primes[i];
        for (long j = i + 1; j < primes.length && sum < LIMIT; j++) {
            sum += primes[j];
            if (isPrime(sum)) {
                long length = j - i + 1;
                if (length > maxLength) { maxLength = length; maxSum = sum; }
            }
        }
    }
    return maxSum;
}

void main() { runSolution!(solve)(50); }
