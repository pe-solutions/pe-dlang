// Reversible Prime Squares
// https://projecteuler.net/problem=808

import std.math : sqrt;
import euler.math : isPrime, reverseDigits;
import euler.common : runSolution;

ulong sumOfReversiblePrimes(uint count) {
    ulong sum = 0;
    uint powersOf10 = 10;
    uint powersOf100 = 100;
    int iteration = 0;

    for (uint n = 13; count > 0; n += (0x2A8Au >> ((iteration++ & 3) << 2)) & 15) {
        if (n > powersOf100) {
            powersOf10 *= 10;
            powersOf100 *= 10;
        }

        uint quotient = n / powersOf10;
        if ((quotient == 1 || quotient == 3) && isPrime(n)) {
            ulong square = cast(ulong)n * n;
            ulong reversedSquare = reverseDigits(square);

            if (reversedSquare != square) {
                uint root = cast(uint)sqrt(cast(real)reversedSquare);

                if (cast(ulong)root * root == reversedSquare && root % 2 > 0 && root % 3 > 0 && isPrime(root)) {
                    count--;
                    sum += square;
                }
            }
        }
    }

    return sum;
}

auto solve() {
    return sumOfReversiblePrimes(50);
}

void main() { runSolution!(solve)(808); }
