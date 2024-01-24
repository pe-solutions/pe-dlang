// Summation of Primes
// https://projecteuler.net/problem=10

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.range: iota;
import std.algorithm: filter, map, sum;

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

void main() {
    StopWatch timer;
    timer.start();
    
    auto answer = iota(2, 2_000_000)
                .filter!(isPrime)
                .sum(0L);
    
    timer.stop();
    
    writefln("\nProject Euler #10\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
