// Diophantine Equation
// https://projecteuler.net/problem=66

import std.bigint : BigInt;
import std.math : sqrt;
import euler.math : isPerfectSquare;
import euler.common : runSolution;

// Minimal x in x² − D·y² = 1 via convergents of the CF expansion of √D.
private BigInt pellMinX(int D) {
    immutable int a0 = cast(int) sqrt(cast(double) D);
    int m = 0, d = 1, a = a0;
    BigInt h2 = BigInt(1), h1 = BigInt(a0);
    BigInt k2 = BigInt(0), k1 = BigInt(1);
    for (;;) {
        m = d * a - m;
        d = (D - m * m) / d;
        a = (a0 + m) / d;
        BigInt h = BigInt(a) * h1 + h2;
        BigInt k = BigInt(a) * k1 + k2;
        if (h * h - k * k * D == 1)
            return h;
        h2 = h1; h1 = h;
        k2 = k1; k1 = k;
    }
}

auto solve() {
    BigInt maxX;
    int bestD;
    foreach (D; 2 .. 1001) {
        if (isPerfectSquare(D)) continue;
        BigInt x = pellMinX(D);
        if (x > maxX) {
            maxX = x;
            bestD = D;
        }
    }
    return bestD;
}

void main() { runSolution!(solve)(66); }
