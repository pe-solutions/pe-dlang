// Singleton Difference
// https://projecteuler.net/problem=136

import euler.common : runSolution;

auto solve() {
    // Same derivation as #135: n=ab, 4|(a+b), b<3a.
    // Let s=a+b (multiple of 4). For fixed b, valid s runs from s_min (s>4b/3,
    // multiple of 4) to s_max (b*(s-b)<N). cnt index = b*(s-b) steps by 4b per
    // s-increment — a single constant stride per b, prefetch-friendly.
    enum int N = 50_000_000;
    auto cnt = new ubyte[N];

    for (int b = 1; ; b++) {
        // smallest multiple of 4 with s > 4b/3  (a=s-b > s/4 ⟺ b < 3a ⟺ s > 4b/3)
        immutable int sMin = (b / 3 + 1) * 4;
        // largest multiple of 4 with b*(s-b) < N
        immutable int sMax = (cast(int)((cast(long)(N - 1) / b) + b) >> 2) << 2;
        if (sMin > sMax) break;
        for (int s = sMin; s <= sMax; s += 4) {
            immutable int n = b * (s - b);
            if (cnt[n] < 2) cnt[n]++;
        }
    }

    int ans = 0;
    foreach (c; cnt[1 .. N])
        if (c == 1) ans++;
    return ans;
}

void main() { runSolution!(solve)(136); }
