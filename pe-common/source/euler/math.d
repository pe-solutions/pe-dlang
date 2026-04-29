module euler.math;

import std.bigint : BigInt;
import std.traits : isIntegral;

bool isPrime(T)(T n) if (isIntegral!T) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    T i = 5;
    while (i * i <= n) {
        if (n % i == 0 || n % (i + 2) == 0) return false;
        i += 6;
    }
    return true;
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

// Returns bool[0..n]: isPrime[i] == true iff i is prime.
bool[] sieve(int n) {
    auto s = new bool[n + 1];
    if (n < 2) return s;
    s[2 .. $] = true;
    for (int j = 4; j <= n; j += 2) s[j] = false;
    for (int i = 3; i * i <= n; i += 2)
        if (s[i])
            for (int j = i * i; j <= n; j += 2 * i)
                s[j] = false;
    return s;
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

T mod(T)(T a, T b) if (isIntegral!T) {
    return (a % b + b) % b;
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

// nth Fibonacci number as type T (default BigInt); for T = long, valid up to n = 93.
T fib(T = BigInt)(int n) if (isIntegral!T || is(T == BigInt)) {
    if (n <= 1) return T(n);
    T a = T(0), b = T(1);
    foreach (_; 2..n + 1) { T c = a + b; a = b; b = c; }
    return b;
}
