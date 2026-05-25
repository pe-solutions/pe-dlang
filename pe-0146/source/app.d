// Investigating a Prime Pattern
// https://projecteuler.net/problem=146

import euler.common : runSolution;

auto solve() {
    import euler.math : isPrime;
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
