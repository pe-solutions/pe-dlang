// Powers with Trailing Digits
// https://projecteuler.net/problem=455

import std.stdio;
import std.datetime.stopwatch;

ulong modularExponentiation(ulong base, ulong exponent, ulong modulus) {
    ulong result = 1;
    
    while (exponent > 0) {
        if (exponent % 2 != 0) {
            result = (result * base) % modulus;
        }
        base = (base * base) % modulus;
        exponent >>= 1;
    }
    
    return result;
}

void main() {
    auto timer = StopWatch(AutoStart.yes);
    
    ulong totalSum = 0;
    
    for (ulong number = 2; number <= 1000000; number += !(++number % 10)) {
        ulong current, next;
        
        for (current = number; ; current = next) {
            next = modularExponentiation(number, current, 1000000000);
            if (next == current) break;
        }
        
        totalSum += current;
    }
    
    writefln("\nProject Euler #455\nAnswer: %s", totalSum);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}

