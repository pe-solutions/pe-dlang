// Exploring Pascal's Triangle
// https://projecteuler.net/problem=148

import euler.common : runSolution;

auto solve() {
    // Lucas' theorem: C(m,k) ≢ 0 (mod 7) iff every base-7 digit of k ≤ the
    // corresponding digit of m.  Row m therefore contributes ∏(dᵢ+1) entries.
    // Summing over m = 0..N uses a digit DP: for each position, free choices
    // contribute tight · (dⱼ(dⱼ+1)/2) · 28^(remaining), where 28 = Σ_{d=0}^{6}(d+1).
    enum long N = 999_999_999L; // first 10⁹ rows (0-indexed 0..10⁹−1)

    int[11] dig;
    int nd = 0;
    for (long t = N; t > 0; t /= 7) dig[nd++] = cast(int)(t % 7);
    for (int i = 0, j = nd - 1; i < j; ++i, --j) { int tmp = dig[i]; dig[i] = dig[j]; dig[j] = tmp; }

    long[12] p28;
    p28[0] = 1;
    foreach (i; 1 .. nd + 1) p28[i] = p28[i - 1] * 28;

    long res = 0, tight = 1;
    foreach (i; 0 .. nd) {
        immutable int d = dig[i];
        res   += tight * (cast(long) d * (d + 1) / 2) * p28[nd - 1 - i];
        tight *= d + 1;
    }
    return res + tight;
}

void main() { runSolution!(solve)(148); }
