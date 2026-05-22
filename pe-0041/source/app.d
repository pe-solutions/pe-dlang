// Pandigital Prime
// https://projecteuler.net/problem=41

import euler.common  : runSolution;

// Enumerate all permutations (ascending start); return largest prime found.
private int largestPandigitalPrime(int[] digits)
{
    import std.algorithm : nextPermutation;
    import euler.math    : isPrime;
    int result = 0;
    do {
        int n = 0;
        foreach (x; digits) n = n * 10 + x;
        if (isPrime(n) && n > result) result = n;
    } while (digits.nextPermutation());
    return result;
}

auto solve()
{
    // n(n+1)/2 is divisible by 3 for n=2,3,5,6,8,9 → only n=4,7 pandigitals can be prime
    if (auto r = largestPandigitalPrime([1, 2, 3, 4, 5, 6, 7])) return r;
    return largestPandigitalPrime([1, 2, 3, 4]);
}

void main() { runSolution!(solve)(41); }
