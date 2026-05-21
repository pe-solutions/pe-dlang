// Counting Fractions in a Range
// https://projecteuler.net/problem=73

import euler.common : runSolution;

// Right-spine jump: instead of recursing step-by-step along the right spine
// (midD, midD+rightD, midD+2*rightD, …), count all k+1 spine fractions at once
// and recurse only into each step's left subtree.
private long count(int leftD, int midD, int rightD) pure nothrow @nogc {
    if (midD > 12_000) return 0;
    immutable int k = (12_000 - midD) / rightD;
    long total = k + 1 + count(leftD, leftD + midD, midD);
    for (int lD = midD, end = midD + k * rightD; lD < end; lD += rightD)
        total += count(lD, 2 * lD + rightD, lD + rightD);
    return total;
}

auto solve() {
    return count(3, 5, 2);
}

void main() { runSolution!(solve)(73); }
