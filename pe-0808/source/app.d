// Reversible Prime Squares
// https://projecteuler.net/problem=808

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.range: iota;
import std.algorithm: filter, map, sum;
import std.math: sqrt;

bool isPrime(int n) {
    if (n <= 1) {
        return false;
    }
    if (n <= 3) {
        return true;
    }
    if (n % 2 == 0 || n % 3 == 0) {
        return false;
    }
    
    int i = 5;
    while (i * i <= n) {
        if (n % i == 0 || n % (i + 2) == 0) {
            return false;
        }
        i += 6;
    }
    
    return true;
}

ulong reverse(ulong n) {
    ulong reversed = 0;
    while (n > 0) {
        reversed *= 10;
        reversed += n % 10;
        n /= 10;
    }
    return reversed;
}

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
            ulong reversedSquare = reverse(square);

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

void main() {
    StopWatch timer;
    timer.start();
    
    auto answer = sumOfReversiblePrimes(50);
    
    timer.stop();
    
    writefln("\nProject Euler #10\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
