// Pandigital Fibonacci Ends
// https://projecteuler.net/problem=104

import euler.common : runSolution;

// True iff n, treated as exactly 9 decimal digits, contains each of 1..9 once.
private bool isPandigital9(long n) pure nothrow @nogc {
    int mask = 0;
    foreach (_; 0 .. 9) {
        immutable d = cast(int)(n % 10);
        if (d == 0 || mask & (1 << d)) return false;
        mask |= 1 << d;
        n /= 10;
    }
    return true;
}

auto solve() {
    import std.math : pow, floor;

    // Binet: log10(F_k) ≈ k·LOG_PHI − LOG_SQRT5.
    // Fractional part gives the leading 9 digits via 10^(frac+8) ∈ [10^8, 10^9).
    // Error ≈ k·ULP(LOG_PHI) ≈ 10^-11 at k ≈ 330 000; well within 10^-9.
    // (Iterative log recurrence is tempting but suffers catastrophic cancellation
    //  as both terms grow large, making it unreliable past a few hundred thousand steps.)
    enum double LOG_PHI   = 0.20898764024997873;  // log10((1+√5)/2)
    enum double LOG_SQRT5 = 0.34948500216800940;  // ½·log10(5)
    enum long   mod       = 1_000_000_000L;

    long tail = 1, tailPrev = 1;  // F_k mod 10^9, F_{k-1} mod 10^9

    for (int k = 3; ; k++) {
        immutable tailNew = (tail + tailPrev) % mod;
        tailPrev = tail;
        tail     = tailNew;

        // Tail is the cheap first filter: ~1 in 2778 pass.
        if (!isPandigital9(tail)) continue;

        // Leading 9 digits from fractional part of log10(F_k).
        immutable frac     = cast(double)k * LOG_PHI - LOG_SQRT5;
        immutable leading9 = cast(long)(pow(10.0, frac - floor(frac) + 8.0));
        if (isPandigital9(leading9)) return k;
    }
    assert(false);
}

void main() { runSolution!(solve)(104); }
