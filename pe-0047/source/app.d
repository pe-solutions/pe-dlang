// Distinct Primes Factors
// https://projecteuler.net/problem=47

import std.stdio;
import std.datetime.stopwatch;
import std.container;
import std.algorithm;

ulong[] generateOmegaSieve(ulong limit) {
    // The Sieve!
    
    ulong[] omegaSieve = new ulong[](limit);

    for (ulong i = 2; i < limit; i++) {
        if (omegaSieve[i] == 0) {
            for (ulong j = i; j < limit; j += i) {
                omegaSieve[j]++;
            }
        }
    }
    
    return omegaSieve;
}

ulong findFirstNumber() {
    // Sieve approach... neither BF nor Memoization is worth it!
	
    ulong limit = 135_000; // ...just above the correct answer ;-)
	
    ulong requiredFactors = 4; // Required number of distinct prime factors

    auto omegaSieve = generateOmegaSieve(limit);

    for (ulong i = 1; i < limit - requiredFactors; i++) {
        bool found = true;
        
        for (ulong j = 0; j < requiredFactors; j++) {
            if (omegaSieve[i + j] != requiredFactors) {
                found = false;
                break;
            }
        }

        if (found) {
            return i;
        }
    }

    return 0; // If no such number is found
}

void main() {
    StopWatch timer;
    timer.start();

    auto answer = findFirstNumber();

    timer.stop();
    
    writefln("\nProject Euler #47\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.", timer.peek.total!"msecs"());
}
