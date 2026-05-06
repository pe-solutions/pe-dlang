// Highly Divisible Triangular Number
// https://projecteuler.net/problem=12

import euler.common : runSolution;
import euler.math : countDivisors;

auto solve() {
    // T_n = n*(n+1)/2. Since gcd(n, n+1) = 1, d(T_n) = d(a) * d(b)
    // where {a, b} = {n/2, n+1} if n is even, else {n, (n+1)/2}.
    // Factoring two smaller coprime numbers is far cheaper than
    // factoring T_n itself.
    long n = 1;
    while (true) {
        immutable long a = (n % 2 == 0) ? n / 2 : n;
        immutable long b = (n % 2 == 0) ? n + 1 : (n + 1) / 2;
        if (countDivisors(a) * countDivisors(b) > 500)
            return n * (n + 1) / 2;
        ++n;
    }
}

void main() { runSolution!(solve)(12); }