// Two-Dimensional Recurrence
// https://projecteuler.net/problem=940

import euler.math : fib, matMul, matPow, matVecMul;
import euler.common : runSolution;

enum long MOD = 1123581313;

// M_row^(-1) mod MOD: det([[0,1],[1,3]]) = -1, so inv = [[MOD-3,1],[1,0]]
enum long[2][2] INV_MROW = [[MOD - 3, 1L], [1L, 0L]];

struct Precomputed {
    long[] fibs;
    long[] dFi;
    long[] dFiPrev;
    long   sumC0, sumC1; // Σ_j M_col^fib(j)[0,0] and [0,1]

    this(int k, long mod) {
        fibs    = new long[k - 1];
        dFi     = new long[k - 1];
        dFiPrev = new long[k - 1];
        for (int i = 2; i <= k; i++) {
            int idx   = i - 2;
            fibs[idx] = fib!long(i);
            // One matPow for the row direction; derive A(fib(i)-1, 0) via M_row^(-1).
            auto Mn      = matPow([[0L, 1L], [1L, 3L]], fibs[idx], mod);
            dFi[idx]     = matVecMul(Mn, [0L, 1L], mod)[0];
            dFiPrev[idx] = matVecMul(matMul([[INV_MROW[0][0], INV_MROW[0][1]],
                                          [INV_MROW[1][0], INV_MROW[1][1]]], Mn, mod),
                                  [0L, 1L], mod)[0];
            // Accumulate column-direction sums; no need to store individual matrices.
            auto Mj = matPow([[0L, 1L], [3L, 1L]], fibs[idx], mod);
            sumC0 = (sumC0 + Mj[0][0]) % mod;
            sumC1 = (sumC1 + Mj[0][1]) % mod;
        }
    }
}

long S(int k, long mod) {
    auto pre = Precomputed(k, mod);
    long total = 0;
    for (int i = 2; i <= k; i++) {
        int  ii   = i - 2;
        long aFi1 = (2 * pre.dFi[ii] + pre.dFiPrev[ii]) % mod;
        total = (total + pre.sumC0 * pre.dFi[ii] % mod
                       + pre.sumC1 * aFi1         % mod) % mod;
    }
    return total;
}

auto solve() {
    return S(50, MOD);
}

void main() { runSolution!(solve)(940); }
