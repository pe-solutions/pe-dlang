// Primes with Runs
// https://projecteuler.net/problem=111

import euler.common : runSolution;

// Binary (Russian-peasant) mulmod — a*b can reach ~10^20 for 10-digit moduli,
// overflowing long. Here a+a ≤ 2*(m-1) < 2·10^10, well within long range.
private long mulmod(long a, long b, long m) pure nothrow @nogc {
    long result = 0;
    a %= m;
    while (b > 0) {
        if (b & 1) { result += a; if (result >= m) result -= m; }
        a += a; if (a >= m) a -= m;
        b >>= 1;
    }
    return result;
}

private long modpow(long b, long e, long m) pure nothrow @nogc {
    long r = 1; b %= m;
    for (; e > 0; e >>= 1) {
        if (e & 1) r = mulmod(r, b, m);
        b = mulmod(b, b, m);
    }
    return r;
}

// Deterministic for n < 2_152_302_898_747 — covers all 10-digit numbers.
private bool isPrime10(long n) pure nothrow @nogc {
    if (n < 2) return false;
    static immutable long[5] w = [2, 3, 5, 7, 11];
    foreach (p; w) {
        if (n == p) return true;
        if (n % p == 0) return false;
    }
    long d = n - 1; int r = 0;
    while (!(d & 1)) { d >>= 1; ++r; }
    foreach (a; w) {
        long x = modpow(a, d, n);
        if (x == 1 || x == n - 1) continue;
        bool composite = true;
        foreach (_; 1 .. r) {
            x = mulmod(x, x, n);
            if (x == n - 1) { composite = false; break; }
        }
        if (composite) return false;
    }
    return true;
}

auto solve() {
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
                if (isPrime10(n)) dSum += n;
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
