// Concealed Square
// https://projecteuler.net/problem=206

import std.math : sqrt;
import euler.common : runSolution;

ulong calculateSquareRootUpperBound() {
    return (cast(ulong)sqrt(cast(double)1929394959697989990uL) / 10) * 10;
}

ulong calculateSquareRootLowerBound() {
    return (cast(ulong)sqrt(cast(double)1020304050607080900uL) / 10) * 10;
}

bool hasConcealedSquarePattern(ulong candidate) {
    candidate /= 100;
    for (ulong digit = 9; digit > 0; digit--, candidate /= 100) {
        if (candidate % 10 != digit) return false;
    }
    return true;
}

auto solve() {
    auto max = calculateSquareRootUpperBound();
    auto min = calculateSquareRootLowerBound();
    for (ulong i = min; i <= max; i += 10) {
        if (hasConcealedSquarePattern(i * i)) return i;
    }
    return 0uL;
}

void main() { runSolution!(solve, 206)(); }
