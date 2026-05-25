// Primes with Runs
// https://projecteuler.net/problem=111

import euler.common : runSolution;

auto solve() {
    import euler.math : isPrime;
    long total = 0;
    foreach (int d; 0 .. 10) {
        long dSum = 0;
        int[10] digs;

        void fill(int pos, int nonD) {
            if (pos == 10) {
                if (digs[0] == 0) return;          // leading zero
                if (digs[9] % 2 == 0) return;      // even last digit
                if (digs[9] == 5) return;           // divisible by 5
                long n = 0;
                foreach (dig; digs) n = n * 10 + dig;
                if (isPrime(n)) dSum += n;
                return;
            }
            immutable rem = 10 - pos;
            // Place d at this position if we still have enough room for nonD non-d digits.
            if (rem > nonD) {
                digs[pos] = d;
                fill(pos + 1, nonD);
            }
            // Place a non-d digit at this position.
            if (nonD > 0) {
                immutable start = (pos == 0) ? 1 : 0;  // no leading zero
                foreach (nd; start .. 10) {
                    if (nd == d) continue;
                    digs[pos] = nd;
                    fill(pos + 1, nonD - 1);
                }
                digs[pos] = d;  // restore
            }
        }

        foreach (nonD; 1 .. 11) {
            dSum = 0;
            fill(0, nonD);
            if (dSum > 0) break;
        }
        total += dSum;
    }
    return total;
}

void main() { runSolution!(solve)(111); }
