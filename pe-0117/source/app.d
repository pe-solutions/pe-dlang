// Red, Green, and Blue Tiles
// https://projecteuler.net/problem=117

import euler.common : runSolution;

auto solve() {
    // Colours may be mixed freely; tile lengths are 1 (black), 2 (red), 3 (green), 4 (blue).
    // Placing a tile of length k at the left end gives: f(n) = Σ_{k=1}^{4} f(n-k).
    enum int N = 50;
    long[N + 1] f;
    f[0] = 1;
    foreach (n; 1 .. N + 1) {
        f[n]  = f[n - 1];
        if (n >= 2) f[n] += f[n - 2];
        if (n >= 3) f[n] += f[n - 3];
        if (n >= 4) f[n] += f[n - 4];
    }
    return f[N];
}

void main() { runSolution!(solve)(117); }
