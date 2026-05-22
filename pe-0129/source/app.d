// Repunit Divisibility
// https://projecteuler.net/problem=129

import euler.common : runSolution;

auto solve() {
    import std.numeric : gcd;

    // R(k) = 111...1 (k ones).  A(n) = min k s.t. n | R(k).
    // Recurrence: R(1)=1, R(k) = R(k-1)*10 + 1.
    // A(n) ≤ n by pigeonhole, so A(n) > 10^6 requires n > 10^6 — start there.
    enum long LIMIT = 1_000_000L;

    for (long n = LIMIT + 1; ; n++) {
        if (gcd(n, 10L) != 1) continue;
        long r = 1;
        long k = 1;
        while (r != 0) {
            r = (r * 10 + 1) % n;
            k++;
        }
        if (k > LIMIT) return n;
    }
    assert(false);
}

void main() { runSolution!(solve)(129); }
