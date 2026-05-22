// Permuted Multiples
// https://projecteuler.net/problem=52

import euler.common : runSolution;

auto solve()
{
    import euler.math : digitFreq;
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
