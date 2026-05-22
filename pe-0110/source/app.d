// Diophantine Reciprocals II
// https://projecteuler.net/problem=110

import euler.common : runSolution;

auto solve() {
    // Same identity as #108: 1/x+1/y=1/n ⟺ (x−n)(y−n)=n²;
    // solutions = (τ(n²)+1)/2. Find min n with count > 4_000_000, i.e. τ(n²) > 7_999_999.
    // Brute force is infeasible; instead build n = p1^a1·p2^a2·… with a1≥a2≥…≥1
    // over the first 15 primes via DFS, pruning branches where n ≥ current best.
    enum long TARGET = 7_999_999L;
    static immutable long[15] primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47];
    long best = long.max;

    void dfs(int idx, int maxExp, long n, long tau) {
        if (tau > TARGET) {
            if (n < best) best = n;
            return;
        }
        if (idx >= 15) return;
        immutable long p = primes[idx];
        long pwr = 1;
        foreach (e; 1 .. maxExp + 1) {
            if (pwr > long.max / p) break;   // p^e overflows
            pwr *= p;
            if (n > long.max / pwr) break;   // n·p^e overflows
            immutable newN = n * pwr;
            if (newN >= best) break;          // pwr monotonically increasing — no improvement
            dfs(idx + 1, e, newN, tau * (2 * e + 1));
        }
    }

    dfs(0, 60, 1, 1);
    return best;
}

void main() { runSolution!(solve)(110); }
