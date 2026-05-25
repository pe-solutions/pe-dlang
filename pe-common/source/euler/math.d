module euler.math;

import std.traits : isIntegral, Unqual;
import std.bigint : BigInt;

// Number of divisors of n via prime factorisation.
// For each prime p with exponent e, contributes (e+1) to the product.
auto countDivisors(T)(T n) if (isIntegral!T) {
    Unqual!T m = n;
    Unqual!T count = 1;
    for (Unqual!T p = 2; p * p <= m; ++p) {
        if (m % p == 0) {
            Unqual!T e = 0;
            while (m % p == 0) { m /= p; ++e; }
            count *= e + 1;
        }
    }
    if (m > 1) count *= 2;  // remaining prime factor
    return count;
}

// Trial division for n ≤ 1_000_000; deterministic Miller-Rabin (9 witnesses {2..23},
// correct for all long values) above that bound.
bool isPrime(T)(T n) if (isIntegral!T) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    if (n > 1_000_000) return isPrimeMR(cast(long)n);
    Unqual!T i = 5;
    while (i * i <= n) {
        if (n % i == 0 || n % (i + 2) == 0) return false;
        i += 6;
    }
    return true;
}

// Overflow-safe (a × b) mod m for arbitrary long values.
// x86-64: hardware 128-bit MUL/DIV; other: Russian-peasant binary method.
long mulmod(long a, long b, long m) pure nothrow @nogc {
    a %= m;
    version (D_InlineAsm_X86_64) {
        long result = void;
        asm pure nothrow @nogc {
            mov RAX, a;
            mov RCX, m;
            mul b;       // RDX:RAX = a*b (unsigned 128-bit)
            div RCX;     // remainder → RDX
            mov result, RDX;
        }
        return result;
    } else {
        long res = 0;
        for (; b > 0; b >>= 1) {
            if (b & 1) { res += a; if (res >= m) res -= m; }
            a <<= 1; if (a >= m) a -= m;
        }
        return res;
    }
}

private long mulpow(long b, long e, long m) pure nothrow @nogc {
    long r = 1; b %= m;
    for (; e > 0; e >>= 1) {
        if (e & 1) r = mulmod(r, b, m);
        b = mulmod(b, b, m);
    }
    return r;
}

// Miller-Rabin with 9 witnesses {2..23}: deterministic for all long values
// (proven bound 3.317×10²⁴ >> long.max ≈ 9.2×10¹⁸).
private bool isPrimeMR(long n) pure nothrow @nogc {
    long d = n - 1; int r = 0;
    while (!(d & 1)) { d >>= 1; ++r; }
    static immutable long[9] w = [2, 3, 5, 7, 11, 13, 17, 19, 23];
    foreach (a; w) {
        if (n == a) return true;
        if (n % a == 0) return false;
        long x = mulpow(a, d, n);
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

// Returns the nth prime using a sieve sized by Rosser's bound: p_n < n*(ln n + ln ln n) for n >= 6.
T nthPrime(T = int)(int n) if (isIntegral!T) {
    import std.math : log;
    if (n == 1) return cast(T)2;
    immutable dn = cast(double)n;
    int limit = n < 6 ? 20 : cast(int)(dn * (log(dn) + log(log(dn)))) + 3;
    auto s = sieve(limit);
    int count = 0;
    foreach (i; 2 .. limit + 1)
        if (s[i] && ++count == n)
            return cast(T)i;
    return cast(T)-1;
}

T largestPrimeFactor(T)(in T n) pure nothrow if (isIntegral!T) {
    T limit = n / 2;
    T retval = n;
    for (T i = 3; i < limit; i += 2) {
        for (T k = retval; k % i == 0; retval = k) {
            k = k / i;
            limit = k / 2;
        }
    }
    return retval;
}

// Returns bool[0..n+1]: result[i] == true iff i is prime.
bool[] sieve(T)(T n) if (isIntegral!T) {
    auto s = new bool[cast(size_t)(n + 1)];
    if (n < 2) return s;
    s[2 .. $] = true;
    for (T j = 4; j <= n; j += 2) s[j] = false;
    for (T i = 3; cast(long)i * i <= n; i += 2)
        if (s[cast(size_t)i])
            for (T j = i * i; j <= n; j += cast(T)(2 * cast(long)i))
                s[cast(size_t)j] = false;
    return s;
}

// Returns bool[] of length (hi-lo+1): result[i] == true iff (lo+i) is prime.
// Only allocates O(hi-lo + sqrt(hi)) memory; efficient for large lo.
bool[] segmentedSieve(T)(T lo, T hi) if (isIntegral!T) {
    import std.math : sqrt;
    size_t len = cast(size_t)(hi - lo + 1);
    auto result = new bool[len];
    result[] = true;
    for (T v = lo; v < cast(T)2 && v <= hi; ++v)
        result[cast(size_t)(v - lo)] = false;
    auto limit = cast(size_t)(sqrt(cast(double)hi)) + 1;
    auto small = sieve(limit);
    foreach (p; 2 .. limit + 1) {
        if (!small[p]) continue;
        T prime = cast(T)p;
        T first = (lo / prime) * prime;
        if (first < lo) first += prime;
        if (first < prime + prime) first = prime + prime;
        for (T j = first; j <= hi; j += prime)
            result[cast(size_t)(j - lo)] = false;
    }
    return result;
}

T reverseDigits(T)(T n) if (isIntegral!T) {
    T reversed = 0;
    while (n > 0) {
        reversed = reversed * 10 + n % 10;
        n /= 10;
    }
    return reversed;
}

bool isPalindrome(T)(T n) if (isIntegral!T) {
    return n == reverseDigits(n);
}

// Digit-multiset fingerprint: nibble per digit 0–9; equal iff same digit multiset.
ulong digitFreq(T)(T n) pure nothrow @nogc if (isIntegral!T) {
    ulong f = 0;
    Unqual!T m = n;
    while (m > 0) { f += 1uL << ((m % 10) * 4); m /= 10; }
    return f;
}

// Sum of the factorials of the decimal digits of n.
T digitFactSum(T)(T n) pure nothrow @nogc if (isIntegral!T) {
    static immutable int[10] fact = [1,1,2,6,24,120,720,5_040,40_320,362_880];
    Unqual!T s = 0, m = cast(Unqual!T)n;
    while (m > 0) { s += fact[m % 10]; m /= 10; }
    return s;
}

// Uses real (80-bit) instead of double so every 64-bit integer is representable exactly;
// checks s-1/s/s+1 to absorb fp rounding in either direction.
bool isPerfectSquare(T)(T n) if (isIntegral!T) {
    import std.math : sqrt;
    if (n <= 0) return false;
    Unqual!T s = cast(Unqual!T)sqrt(cast(real)n);
    if (s > 0 && (s - 1) * (s - 1) == n) return true;
    if (s * s == n) return true;
    if ((s + 1) * (s + 1) == n) return true;
    return false;
}

// Pentagonal number generator: P(n) = n*(3n-1)/2.
T pent(T)(T n) pure nothrow @nogc if (isIntegral!T) {
    Unqual!T m = cast(Unqual!T)n;
    return m * (3 * m - 1) / 2;
}

// True if n is a pentagonal number: 24n+1 must be a perfect square s with (s+1) % 6 == 0.
bool isPent(T)(T n) pure nothrow @nogc if (isIntegral!T) {
    import std.math : sqrt;
    Unqual!T d  = 24 * cast(Unqual!T)n + 1;
    Unqual!T s  = cast(Unqual!T)sqrt(cast(real)d);
    if (s * s == d) return (s + 1) % 6 == 0;
    Unqual!T s1 = s + 1;
    return s1 * s1 == d && (s1 + 1) % 6 == 0;
}

T mod(T)(T a, T b) if (isIntegral!T) {
    return (a % b + b) % b;
}

// Binomial coefficient C(n, k). Returns 0 for k < 0 or k > n.
// Intermediate divisions are exact; result fits in long for n ≤ 66.
long binomial(int n, int k) pure nothrow @nogc {
    if (k < 0 || k > n) return 0;
    if (k > n - k) k = n - k;
    long result = 1;
    foreach (i; 0 .. k)
        result = result * (n - i) / (i + 1);
    return result;
}

// 2×2 matrix multiplication mod modulus.
long[][] matMul(long[][] A, long[][] B, long modulus) {
    long[][] C = [[0L, 0L], [0L, 0L]];
    for (int i = 0; i < 2; i++)
        for (int j = 0; j < 2; j++)
            for (int p = 0; p < 2; p++)
                C[i][j] = (C[i][j] + (A[i][p] * B[p][j]) % modulus) % modulus;
    return C;
}

// 2×2 matrix × 2-vector multiplication mod modulus.
long[] matVecMul(long[][] M, long[] v, long modulus) {
    long[] r = [0L, 0L];
    for (int i = 0; i < 2; i++)
        for (int j = 0; j < 2; j++)
            r[i] = (r[i] + (M[i][j] * v[j]) % modulus) % modulus;
    return r;
}

// 2×2 matrix power M^n mod modulus via square-and-multiply; n may be any integral type or BigInt.
long[][] matPow(N)(long[][] M, N n, long modulus) if (isIntegral!N || is(N == BigInt)) {
    long[][] result = [[1L, 0L], [0L, 1L]];
    long[][] base = M;
    while (n > 0) {
        if (n % 2 == 1) result = matMul(result, base, modulus);
        base = matMul(base, base, modulus);
        n /= 2;
    }
    return result;
}

// Index of the first Fibonacci number with at least d decimal digits.
// Derived from Binet's formula F(n) ~ phi^n/sqrt(5); uses 80-bit real for precision.
int fibFirstNDigits(int d) {
    import std.math : ceil, log10, sqrt;
    enum real phi = (1.0L + sqrt(5.0L)) / 2.0L;
    return cast(int) ceil((cast(real)(d - 1) + 0.5L * log10(5.0L)) / log10(phi));
}

// nth Fibonacci number as type T (default BigInt); for T = long, valid up to n = 93.
T fib(T = BigInt)(int n) if (isIntegral!T || is(T == BigInt)) {
    if (n <= 1) return T(n);
    T a = T(0), b = T(1);
    foreach (_; 2..n + 1) { T c = a + b; a = b; b = c; }
    return b;
}

unittest {
    assert(binomial(0,  0) == 1);
    assert(binomial(5,  2) == 10);
    assert(binomial(10, 3) == 120);
    assert(binomial(10, -1) == 0);
    assert(binomial(10, 11) == 0);
}

unittest {
    // trial-division path (n ≤ 1_000_000)
    assert(!isPrime(0) && !isPrime(1) && !isPrime(4) && !isPrime(9) && !isPrime(1_000_000));
    assert( isPrime(2) &&  isPrime(3) &&  isPrime(5) &&  isPrime(997));

    // Miller-Rabin path (n > 1_000_000) — 9 witnesses, covers full long range
    assert(!isPrime!long(1_000_001L));          // 101 × 9901
    assert( isPrime!long(1_000_003L));          // prime
    assert( isPrime!long(15_485_863L));         // 1_000_000th prime
    assert( isPrime!long(1_000_000_007L));      // well-known large prime
    assert(!isPrime!long(7L * 459_290_253L));   // 3_215_031_771 — composite above old ~3.2B boundary
}
