// Permuted Multiples
// https://projecteuler.net/problem=52

import euler.common : runSolution;

// Pack digit frequencies into nibbles (4 bits per digit 0–9); equal iff same multiset.
private ulong digitFreq(int n) pure nothrow @nogc
{
    ulong f = 0;
    while (n > 0) { f += 1uL << ((n % 10) * 4); n /= 10; }
    return f;
}

auto solve()
{
    // x and 6x share digit count iff x < 10^d / 6, i.e. x starts with 1.
    // Iterate directly over each digit-length band [10^(d-1), 10^d / 6].
    for (int pow10 = 10; ; pow10 *= 10)
    {
        foreach (x; pow10 / 10 .. pow10 / 6 + 1)
        {
            immutable fx = digitFreq(x);
            if (digitFreq(2*x) == fx && digitFreq(3*x) == fx &&
                digitFreq(4*x) == fx && digitFreq(5*x) == fx &&
                digitFreq(6*x) == fx)
                return x;
        }
    }
}

void main() { runSolution!(solve)(52); }
