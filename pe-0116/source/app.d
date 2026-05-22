// Red, Green or Blue Tiles
// https://projecteuler.net/problem=116

import euler.common : runSolution;

auto solve() {
    // For each colour length L ∈ {2,3,4}: count tilings of 50 units with
    // 1-unit black and L-unit coloured tiles (single colour, no mixing).
    // g(n) = g(n-1) + g(n-L);  g(0..L-1) = 1.
    // Subtract 1 per colour to exclude the all-black tiling.
    enum int N = 50;
    long total = 0;
    foreach (L; [2, 3, 4]) {
        long[N + 1] g;
        g[0] = 1;
        foreach (n; 1 .. N + 1)
            g[n] = g[n - 1] + (n >= L ? g[n - L] : 0L);
        total += g[N] - 1;
    }
    return total;
}

void main() { runSolution!(solve)(116); }
