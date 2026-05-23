// Modified Fibonacci Golden Nuggets
// https://projecteuler.net/problem=140

import euler.common : runSolution;

// A_G(x) = (x + 3x²)/(1 − x − x²) = n requires 5n² + 14n + 1 = k².
// Setting m = 5n + 7 gives the Pell-like equation m² − 5k² = 44.  The eight
// base solutions (7,±1), (8,±2), (13,±5), (17,±7) yield six distinct orbits
// under the fundamental automorphism (9 + 4√5); (17,7) and (17,−7) are each
// one step into an orbit whose representative has m = 13.  Each orbit with
// m ≡ 2 (mod 5) gives integer n = (m−7)/5.  Squaring the automorphism yields
// the two-step recurrence n' = 161n + 72k + 224, k' = 360n + 161k + 504.
auto solve() {
    import std.algorithm : sort, sum;

    // Starting (n, k) for each of the six solution families
    static immutable long[2][6] starts = [
        [  2,   7],   // orbit (13,−5)→(17,7): n = 2
        [  5,  14],   // orbit (8,−2)→(32,14): n = 5
        [ 21,  50],   // orbit (8,2)→(112,50): n = 21
        [ 42,  97],   // orbit (13,5)→(217,97): n = 42
        [152, 343],   // orbit (7,−1)→…→(767,343): n = 152
        [296, 665],   // orbit (7,1)→…→(1487,665): n = 296
    ];

    long[] nuggets;
    nuggets.reserve(42);
    foreach (s; starts) {
        long n = s[0], k = s[1];
        foreach (_; 0 .. 7) {
            nuggets ~= n;
            immutable long nn = 161 * n + 72 * k + 224;
            immutable long kk = 360 * n + 161 * k + 504;
            n = nn;
            k = kk;
        }
    }

    sort(nuggets);
    return nuggets[0 .. 30].sum;
}

void main() { runSolution!(solve)(140); }
