// Optimum Polynomial
// https://projecteuler.net/problem=101

import euler.common : runSolution;

// Generating polynomial: u(n) = 1 - n + n^2 - n^3 + ... + n^10
private long u(long n) pure nothrow @nogc {
    long result = 0, sign = 1, power = 1;
    foreach (_; 0 .. 11) {
        result += sign * power;
        power *= n;
        sign = -sign;
    }
    return result;
}

// Approach 1 — finite differences (default)
// Newton's identity: OP(k, k+1) = u(k+1) − Δᵏu(1).
// The difference table is built in-place; O(n²) total, no helpers needed.
private long solveFiniteDiff() pure nothrow @nogc {
    long[12] uv;
    foreach (n; 1 .. 12) uv[n] = u(n);
    long[11] d;
    foreach (i; 0 .. 11) d[i] = uv[i + 1];
    long total = 0;
    foreach (k; 1 .. 11) {
        foreach (i; 0 .. 11 - k) d[i] = d[i + 1] - d[i];
        total += uv[k + 1] - d[0];
    }
    return total;
}

// Approach 2 — closed-form Lagrange weights
// For integer nodes {1..k} evaluated at x = k+1, the i-th Lagrange basis
// weight simplifies to C(k, i-1) · (-1)^(k-i), eliminating any matrix solve.
// binom is scoped here — it is not shared with any other approach.
private long solveLagrange() pure nothrow @nogc {
    long binom(int n, int k) pure nothrow @nogc {
        if (k > n - k) k = n - k;
        long result = 1;
        foreach (i; 0 .. k)
            result = result * (n - i) / (i + 1);
        return result;
    }
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

auto solve() {
    immutable result = solveFiniteDiff();
    assert(solveLagrange() == result, "implementations disagree");  // stripped by -release
    return result;
}

void main() { runSolution!(solve)(101); }
