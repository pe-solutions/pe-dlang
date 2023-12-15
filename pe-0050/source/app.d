// Consecutive Prime Sum
// https://projecteuler.net/problem=50

import std.stdio;
import std.datetime.stopwatch;
import std.range;
import std.algorithm;
import std.array;
import std.math;
import std.conv;

bool isPrime(long n) {
    if (n <= 1) {
        return false;
    }
	
    for (long i = 2; i <= cast(long) (n ^^ 0.5); i++) {
        if (n % i == 0) {
            return false;
        }
    }
	
    return true;
}

long sum_of_primes(long n) {
    auto primes = iota(2L, n).filter!(isPrime).array;
    
    long maxSum = 0;
    long maxLength = 0;
    
    for (long i = 0; i < primes.length; i++) {
        long sum = primes[i];
        
        for (long j = i + 1; j < primes.length && sum < n; j++) {
            sum += primes[j];
            
            if (isPrime(sum)) {
                long length = j - i + 1;
                
                if (length > maxLength) {
                    maxLength = length;
                    maxSum = sum;
                }
            }
        }
    }

    return maxSum;
}

void main() {

    StopWatch timer;
    timer.start();

    const long LIMIT = 1_000_000L;
    auto answer = sum_of_primes(LIMIT);
        
    timer.stop();

    writefln("\nProject Euler #50\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
