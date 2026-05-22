// Bouncy Numbers
// https://projecteuler.net/problem=112

import euler.common : runSolution;

// Digits scanned right-to-left: d is the current (leftward) digit, prev the one to its right.
// d < prev ⟹ sequence increases left-to-right (hasUp); d > prev ⟹ it decreases (hasDown).
private bool isBouncy(int n) pure nothrow @nogc {
    int prev = n % 10;
    n /= 10;
    bool hasUp, hasDown;
    while (n > 0) {
        immutable d = n % 10;
        if (d < prev) hasUp   = true;
        else if (d > prev) hasDown = true;
        if (hasUp && hasDown) return true;
        prev = d;
        n /= 10;
    }
    return false;
}

auto solve() {
    int bouncy = 0;
    for (int n = 1; ; n++) {
        if (isBouncy(n)) ++bouncy;
        if (bouncy * 100 == n * 99) return n;
    }
    assert(false);
}

void main() { runSolution!(solve)(112); }
