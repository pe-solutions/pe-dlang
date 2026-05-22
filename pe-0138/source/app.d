// Special Isosceles Triangles
// https://projecteuler.net/problem=138

import euler.common : runSolution;

// h² + (b/2)² = L², h = b±1; b must be even (b=2c) for integer h.
//   h = b−1: L²=5c²−4c+1 ⟹ (5c−2)²−5L²=−1
//   h = b+1: L²=5c²+4c+1 ⟹ (5c+2)²−5L²=−1
// Both reduce to x²−5y²=−1 (Pell); L values are consecutive y-solutions and
// satisfy L_{k+1}=18L_k−L_{k-1}. L_0=1 corresponds to b=0 (excluded); L_1=17.
// Sum the first 12 valid L values.
auto solve() pure nothrow @nogc {
    long sum = 0;
    long prev = 1, curr = 17;
    foreach (_; 0 .. 12) {
        sum += curr;
        immutable t = 18*curr - prev;
        prev = curr;
        curr = t;
    }
    return sum;
}

void main() { runSolution!(solve)(138); }
