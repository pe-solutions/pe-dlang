// Square Root Digital Expansion
// https://projecteuler.net/problem=80

import std.bigint : BigInt;
import std.conv : to;
import euler.math : isPerfectSquare;
import euler.common : runSolution;

// Integer square root via Newton's method, starting from 10^ceil(digits/2).
private BigInt isqrt(BigInt n) {
    if (n == 0) return BigInt(0);
    int halfLen = (cast(int)n.to!string.length + 1) / 2;
    BigInt x = BigInt(1);
    foreach (_; 0 .. halfLen) x *= 10;
    BigInt x1 = (x + n / x) / 2;
    while (x1 < x) { x = x1; x1 = (x + n / x) / 2; }
    return x;
}

auto solve() {
    // floor(sqrt(n * 10^198)) gives the first 100 significant digits of sqrt(n)
    // as a 100-digit integer (since sqrt(n) < 10 for n < 100).
    BigInt scale = BigInt(1);
    foreach (_; 0 .. 198) scale *= 10;

    int total = 0;
    foreach (n; 2 .. 100) {
        if (isPerfectSquare(n)) continue;
        foreach (c; isqrt(BigInt(n) * scale).to!string)
            total += c - '0';
    }
    return total;
}

void main() { runSolution!(solve)(80); }
