// How many reversible numbers are there below one-billion?
// https://projecteuler.net/problem=145

import euler.common : runSolution;

auto solve() {
    // n must not end in 0 (else rev(n) has a leading zero).
    // Carry analysis on the d-digit addition n + rev(n):
    //   Even d=2k: zero-carry solution only; outer pair sum odd<10 (both digits ≥1: 20),
    //              inner pair sum odd<10 (digits ≥0: 30 each). Count = 20·30^(k−1).
    //   Odd d≡1 (mod 4): carry parity conflict at middle digit → 0.
    //   Odd d≡3 (mod 4): non-zero only for d=3 (100) and d=7 (50000) below 10^9.

    long ans = 0;
    foreach (k; 1 .. 5)               // d = 2, 4, 6, 8
        ans += 20L * 30 ^^ (k - 1);
    ans += 100;                        // d = 3: 20 outer pairs × 5 middle digits
    ans += 50_000;                     // d = 7: 20 × 25 × 20 × 5
    return ans;
}

void main() { runSolution!(solve)(145); }
