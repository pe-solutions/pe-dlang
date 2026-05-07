// Almost Equilateral Triangles
// https://projecteuler.net/problem=94

import euler.common : runSolution;

// Triangles a,a,b with |b-a|=1 and integer area satisfy the Pell-like equation
// p^2 - 3*q^2 = 4, where p = 3a-1 (b=a+1) or p = 3a+1 (b=a-1).
// Recurrence: p_n = 4*p_{n-1} - p_{n-2}, starting from (2, 4).
// Perimeter = p+2 when p%3==2, or p-2 when p%3==1.
auto solve() {
    long sum = 0;
    long p0 = 2, p1 = 4;

    while (true) {
        immutable long p = 4 * p1 - p0;
        p0 = p1;
        p1 = p;

        immutable long perimeter = (p % 3 == 2) ? p + 2 : p - 2;
        if (perimeter > 1_000_000_000) break;
        sum += perimeter;
    }

    return sum;
}

void main() { runSolution!(solve)(94); }
