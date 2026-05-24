// Searching for a Maximum-sum Subsequence
// https://projecteuler.net/problem=149

import euler.common : runSolution;

private long kadane(const int[] a) pure nothrow @nogc {
    import std.algorithm.comparison : max;
    long best = a[0], cur = a[0];
    foreach (x; a[1 .. $]) {
        cur = max(cast(long) x, cur + x);
        best = max(best, cur);
    }
    return best;
}

auto solve() {
    import std.algorithm.comparison : max;

    enum int N = 2000;

    // Generate the sequence s[0..N²-1] (flat row-major grid)
    auto s = new int[](N * N);

    for (int k = 1; k <= 55; ++k) {
        immutable long k3 = cast(long) k * k * k;
        s[k - 1] = cast(int)((100003L - 200003L * k + 300007L * k3) % 1_000_000) - 500_000;
    }
    for (int k = 56; k <= N * N; ++k)
        s[k - 1] = (s[k - 25] + s[k - 56] + 1_000_000) % 1_000_000 - 500_000;

    long ans = long.min;
    auto buf = new int[](N);

    // Rows
    foreach (r; 0 .. N)
        ans = max(ans, kadane(s[r * N .. (r + 1) * N]));

    // Columns
    foreach (c; 0 .. N) {
        foreach (r; 0 .. N) buf[r] = s[r * N + c];
        ans = max(ans, kadane(buf));
    }

    // Main diagonals: d = c - r, d ∈ [-(N-1), N-1]
    foreach (d; -(N - 1) .. N) {
        immutable int r0  = d < 0 ? -d : 0;
        immutable int len = N - (d < 0 ? -d : d);
        foreach (i; 0 .. len) buf[i] = s[(r0 + i) * N + (r0 + i + d)];
        ans = max(ans, kadane(buf[0 .. len]));
    }

    // Anti-diagonals: d = c + r, d ∈ [0, 2*(N-1)]
    foreach (d; 0 .. 2 * N - 1) {
        immutable int r0  = d > N - 1 ? d - (N - 1) : 0;
        immutable int r1  = d < N ? d : N - 1;
        immutable int len = r1 - r0 + 1;
        foreach (i; 0 .. len) buf[i] = s[(r0 + i) * N + (d - r0 - i)];
        ans = max(ans, kadane(buf[0 .. len]));
    }

    return ans;
}

void main() { runSolution!(solve)(149); }
