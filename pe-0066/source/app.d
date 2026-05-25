// Diophantine Equation
// https://projecteuler.net/problem=66

import euler.common : runSolution;

auto solve() {
    import std.bigint : BigInt;
    import euler.math  : isPerfectSquare, pellMinX;
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
