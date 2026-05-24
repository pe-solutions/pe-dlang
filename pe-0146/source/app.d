// Investigating a Prime Pattern
// https://projecteuler.net/problem=146

import euler.common : runSolution;

// Hardware 128-bit MUL + DIV on x86-64; binary fallback elsewhere.
// Values fit: n < 1.5e8 → n²+k < 2.26e16 < 2^54.3; quotient < m < 2^63. ✓
private long mulmod(long x, long y, long m) {
    x %= m;
    version (D_InlineAsm_X86_64) {
        long result = void;
        asm {
            mov RAX, x;
            mov RCX, m;
            mul y;       // RDX:RAX = x * y  (unsigned 128-bit)
            div RCX;     // quotient→RAX, remainder→RDX
            mov result, RDX;
        }
        return result;
    } else {
        long res = 0;
        for (; y > 0; y >>= 1) {
            if (y & 1) { res += x; if (res >= m) res -= m; }
            x <<= 1; if (x >= m) x -= m;
        }
        return res;
    }
}

private long powmod(long base, long exp, long mod) {
    long result = 1;
    base %= mod;
    for (; exp > 0; exp >>= 1) {
        if (exp & 1) result = mulmod(result, base, mod);
        base = mulmod(base, base, mod);
    }
    return result;
}

private bool millerRabin(long n, long a) {
    if (n % a == 0) return n == a;
    long d = n - 1;
    int  r = 0;
    while ((d & 1) == 0) { d >>= 1; ++r; }
    long x = powmod(a, d, n);
    if (x == 1 || x == n - 1) return true;
    for (int i = 0; i < r - 1; ++i) {
        x = mulmod(x, x, n);
        if (x == n - 1) return true;
    }
    return false;
}

// Deterministic for n < 3.825×10¹⁸.
private bool isPrime(long n) {
    if (n < 2)  return false;
    if (n == 2) return true;
    if ((n & 1) == 0) return false;
    static immutable long[9] ws = [2, 3, 5, 7, 11, 13, 17, 19, 23];
    foreach (a; ws)
        if (!millerRabin(n, a)) return false;
    return true;
}

auto solve() {
    // n≡0 mod 10: even (n²+odd is odd) and n≡0 mod 5 (n²+{5,15,25}≡0 mod 5).
    // Mod-3: n≢0 mod 3 else n²+3 divisible by 3.
    // Mod-7: only n≡3,4 mod 7 leave n²≡2 mod 7; all other residues kill a target.
    // Mod-11: n≡{2,9}→n²+7≡0; n≡{3,8}→n²+13≡0.
    // Mod-13: n≡{0,2,5,6,7,8,11}→a target value ≡0.
    //
    // Among odd "between" offsets {5,11,15,17,19,21,23,25}, all auto-composite:
    //   +{5,15,25}: div by 5;  +{11,17,23}: n²≡1 mod 3 → div by 3;
    //   +19: n²≡2 mod 7 → div by 7.
    // Only n²+21 needs an explicit primality check.

    enum long LIMIT = 150_000_000L;
    long sum = 0;

    for (long n = 10; n < LIMIT; n += 10) {
        if (n % 3 == 0) continue;
        { immutable r = n % 7;  if (r != 3 && r != 4) continue; }
        { immutable r = n % 11; if (r == 2 || r == 3 || r == 8 || r == 9) continue; }
        { immutable r = n % 13; if (r == 0 || r == 2 || r == 5 || r == 6 ||
                                     r == 7 || r == 8 || r == 11) continue; }

        immutable long n2 = n * n;

        if ( isPrime(n2 + 21)) continue;   // only non-auto-composite "between" value
        if (!isPrime(n2 +  1)) continue;
        if (!isPrime(n2 +  3)) continue;
        if (!isPrime(n2 +  7)) continue;
        if (!isPrime(n2 +  9)) continue;
        if (!isPrime(n2 + 13)) continue;
        if (!isPrime(n2 + 27)) continue;

        sum += n;
    }

    return sum;
}

void main() { runSolution!(solve)(146); }
