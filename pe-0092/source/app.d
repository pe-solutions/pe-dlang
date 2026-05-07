// Square Digit Chains
// https://projecteuler.net/problem=92

import euler.common : runSolution;

int digitSquareSum(int n) {
    int s = 0;
    while (n > 0) { int d = n % 10; s += d * d; n /= 10; }
    return s;
}

auto solve() {
    enum MAX_SUM = 7 * 81;  // 567: max digit-square sum for any number < 10^7

    bool[MAX_SUM + 1] endsAt89;
    foreach (i; 1 .. MAX_SUM + 1) {
        int n = i;
        while (n != 1 && n != 89) n = digitSquareSum(n);
        endsAt89[i] = (n == 89);
    }

    // Digit-DP: free[s] = count of suffix sequences (digits 0-9, current length)
    // with digit-square sum s.  Prepend a non-zero leading digit each round to form
    // a valid number; extend suffixes by one free digit for the next round.
    long[MAX_SUM + 1] free;
    free[0] = 1;  // empty suffix

    long total = 0;
    foreach (_; 0 .. 7) {
        foreach (s; 0 .. MAX_SUM + 1) {
            if (free[s] == 0) continue;
            foreach (d; 1 .. 10) {            // non-zero leading digit
                int ns = s + d * d;
                if (ns <= MAX_SUM && endsAt89[ns])
                    total += free[s];
            }
        }
        long[MAX_SUM + 1] next;
        foreach (s; 0 .. MAX_SUM + 1) {
            if (free[s] == 0) continue;
            foreach (d; 0 .. 10) {            // free suffix digit
                int ns = s + d * d;
                if (ns <= MAX_SUM) next[ns] += free[s];
            }
        }
        free = next;
    }

    return total;
}

void main() { runSolution!(solve)(92); }
