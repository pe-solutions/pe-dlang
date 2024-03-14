// 10001st Prime
// https://projecteuler.net/problem=7

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;

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
    
    for (int i = 5; i * i <= n; i += 6) {
        if (n % i == 0 || n % (i + 2) == 0) {
            return false;
        }
    }
    
    return true;
}

int nthPrime(int n) {
    if (n == 1) {
        return 2;
    }
    
    int primeCount = 1; // Counts the prime numbers found so far
    int candidate = 3;  // Start with the first odd number after 2
    
    for(;;) {
        if (isPrime(candidate)) {
            primeCount++;
            
            if (primeCount == n) {
                return candidate;
            }
        }
        
        candidate += 2; // Move to the next odd number
    }
}

void main() {
    StopWatch timer;
    timer.start();
    
    auto answer = nthPrime(10_001);
    
    timer.stop();
    
    writefln("\nProject Euler #7\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
