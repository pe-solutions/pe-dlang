// Concealed Square
// https://projecteuler.net/problem=206

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.math: sqrt;
import std.range: iota;
import std.algorithm: filter, sum;
import std.numeric: gcd;

ulong calculateSquareRootUpperBound() {
    return (cast(ulong)sqrt(cast(double)1929394959697989990uL) / 10) * 10;
}

ulong calculateSquareRootLowerBound() {
    return (cast(ulong)sqrt(cast(double)1020304050607080900uL) / 10) * 10;
}

bool hasConcealedSquarePattern(ulong candidate) {
    candidate /= 100;

    for (ulong digit = 9; digit > 0; digit--, candidate /= 100) {
        if (candidate % 10 != digit) {
            return false;
        }
    }

    return true;
}

void main() {
    StopWatch timer;
    timer.start();
    
    auto max = calculateSquareRootUpperBound();
    auto min = calculateSquareRootLowerBound();

    ulong answer= 0;

    for (ulong i = min; i <= max; i += 10) {
        auto candidate = i * i;

        if (hasConcealedSquarePattern(candidate)) {
            answer = i;
            break;
        }
    }
        
    timer.stop();
        
    writefln("\nProject Euler #206\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
