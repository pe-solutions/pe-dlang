// Digit Power Sum
// https://projecteuler.net/problem=119

import euler.common : runSolution;

auto solve() {
    import euler.math : digitSum;
    import std.algorithm : sort;

    // Collect every n = b^k (b ≥ 2, k ≥ 2) where digit_sum(n) = b.
    // Overflow guard: break when pw > LIMIT/b before multiplying.
    enum long LIMIT = 1_000_000_000_000_000_000L;  // 10^18
    long[] seq;
    foreach (b; 2 .. 200) {
        long pw = b;
        for (;;) {
            if (pw > LIMIT / b) break;
            pw *= b;
            if (digitSum(pw) == b) seq ~= pw;
        }
    }
    sort(seq);
    return seq[29];
}

void main() { runSolution!(solve)(119); }
