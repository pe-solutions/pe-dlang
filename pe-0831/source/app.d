// Triple Product
// https://projecteuler.net/problem=831

import std.bigint;
import euler.common : runSolution;

BigInt g(BigInt m) {
    // Polynomial interpolation
    auto m4 = m * m * m * m;
    auto m5 = m4 * m;
    auto numerator = BigInt(81) * m5 + BigInt(153 * 5) * m4;
    return numerator / BigInt(40);
}

// Convert a non-negative BigInt to a string in the given radix (2..=36)
string toBase(BigInt n, int radix)
in (radix >= 2 && radix <= 36)
{
    if (n == 0) return "0";

    immutable string digits = "0123456789abcdefghijklmnopqrstuvwxyz";
    char[] result;
    BigInt v = n;
    const base = BigInt(radix);

    while (v > 0) {
        auto digit = cast(int)(v % base).toLong();
        result ~= digits[digit];
        v /= base;
    }

    foreach (i; 0 .. result.length / 2) {
        auto tmp = result[i];
        result[i] = result[$ - 1 - i];
        result[$ - 1 - i] = tmp;
    }

    return result.idup;
}

auto solve() {
    auto base7 = toBase(g(BigInt(142857)), 7);
    auto topDigits = base7[0 .. 10];
    return BigInt(topDigits);
}

void main() { runSolution!(solve)(831); }