// Same Differences
// https://projecteuler.net/problem=135

import euler.common : runSolution;

auto solve() {
    import std.algorithm : min;

    // x²−y²−z²=n, y=x−d, z=x−2d (AP, all positive) simplifies to
    // n=(x−d)(5d−x). Set a=x−d, b=5d−x: n=ab, a+b=4d, z=a−d=a−(a+b)/4>0⟺b<3a.
    // Count factorizations n=ab with 4|(a+b) and b<3a; sieve over all a.
    enum int N = 1_000_000;
    auto cnt = new int[N];

    for (int a = 1; a < N; a++) {
        immutable int bMax   = min(3*a - 1, (N - 1) / a);
        immutable int bStart = (4 - a % 4) % 4;
        for (int b = bStart == 0 ? 4 : bStart; b <= bMax; b += 4)
            cnt[a * b]++;
    }

    int ans = 0;
    foreach (c; cnt[1 .. N])
        if (c == 10) ans++;
    return ans;
}

void main() { runSolution!(solve)(135); }
