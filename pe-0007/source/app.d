// 10001st Prime
// https://projecteuler.net/problem=7

import euler.math : isPrime;
import euler.common : runSolution;

int nthPrime(int n) {
    if (n <= 0) return -1;
    if (n == 1) return 2;
    int primeCount = 1;
    for (int candidate = 3; ; candidate += 2) {
        if (isPrime(candidate) && ++primeCount == n)
            return candidate;
    }
}

auto solve() { return nthPrime(10_001); }

void main() { runSolution!(solve, 7)(); }
