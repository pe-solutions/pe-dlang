// Palindromic Sums
// https://projecteuler.net/problem=125

import euler.common : runSolution;

auto solve() {
    import euler.math    : isPalindrome;
    import std.algorithm : sort, uniq, sum;

    enum long LIMIT = 100_000_000L;

    long[] pals;

    // Outer loop: starting square index a; minimum 2-term sum = a²+(a+1)².
    for (long a = 1; ; a++) {
        long s = a * a + (a + 1) * (a + 1);
        if (s >= LIMIT) break;
        // Inner loop: check current sum, then extend by one more square.
        for (long b = a + 2; ; b++) {
            if (isPalindrome(s)) pals ~= s;
            s += b * b;
            if (s >= LIMIT) break;
        }
    }

    sort(pals);
    return uniq(pals).sum;
}

void main() { runSolution!(solve)(125); }
