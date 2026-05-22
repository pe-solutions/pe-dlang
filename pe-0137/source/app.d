// Fibonacci Golden Nuggets
// https://projecteuler.net/problem=137

import euler.common : runSolution;

// A_F(x) = x/(1−x−x²) = n requires 5n²+2n+1 = k²; substituting m=5n+1
// reduces to 5k²−m²=4. The integer solutions satisfy n_j = F_{2j}·F_{2j+1},
// so n_15 = F_30·F_31.
private long solveFib() pure nothrow @nogc {
    long a = 1, b = 1;
    foreach (_; 0 .. 28) { immutable t = a + b; a = b; b = t; }
    return b * (a + b);   // F_30 * F_31
}

// Recurrence: n_{k+1} = 7n_k − n_{k-1} + 1, n_0=0, n_1=2.
private long solveRecurrence() pure nothrow @nogc {
    long n0 = 0, n1 = 2;
    foreach (_; 0 .. 14) { immutable t = 7*n1 - n0 + 1; n0 = n1; n1 = t; }
    return n1;
}

auto solve() {
    immutable result = solveFib();
    assert(solveRecurrence() == result, "recurrence disagrees");
    return result;
}

void main() { runSolution!(solve)(137); }
