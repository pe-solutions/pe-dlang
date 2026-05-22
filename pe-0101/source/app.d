// Optimum Polynomial
// https://projecteuler.net/problem=101

import euler.common : runSolution;

// u(n) = 1 - n + n^2 - n^3 + ... + n^10
private long u(long n) pure nothrow @nogc {
    long result = 0, sign = 1, power = 1;
    foreach (_; 0 .. 11) {
        result += sign * power;
        power *= n;
        sign = -sign;
    }
    return result;
}

private long binom(int n, int k) pure nothrow @nogc {
    if (k > n - k) k = n - k;
    long result = 1;
    foreach (i; 0 .. k)
        result = result * (n - i) / (i + 1);
    return result;
}

auto solve() {
    // Lagrange interpolation at x = k+1 through points (1..k):
    // OP(k, k+1) = Σ_{i=1}^{k} u(i) · C(k, i-1) · (-1)^(k-i)
    long total = 0;
    foreach (k; 1 .. 11) {
        long fit = 0;
        foreach (i; 1 .. k + 1) {
            immutable sign = (k - i) % 2 == 0 ? 1L : -1L;
            fit += u(i) * binom(k, i - 1) * sign;
        }
        total += fit;
    }
    return total;
}

void main() { runSolution!(solve)(101); }
