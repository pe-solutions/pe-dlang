// 10001st Prime
// https://projecteuler.net/problem=7

import std.stdio;
import std.datetime.stopwatch: StopWatch;

int nthPrime(int n) {
    if (n <= 0) {
        return -1;
    }
    
    if (n == 1) {
        return 2;
    }
    
    int primeCount = 1;
    int candidate = 3;
    
    for( ; ; candidate += 2) {
        bool isPrime = true;
        
        for (int i = 3; i * i <= candidate; i += 2) {
            if (candidate % i == 0) {
                isPrime = false;
                break;
            }
        }
        
        if (isPrime) {
            primeCount++;
            
            if (primeCount == n) {
                return candidate;
            }
        }
    }
}

void main() {
    auto timer = StopWatch(AutoStart.yes);
    
    const int N = 10_001;
    
    auto answer = nthPrime(N);
    
    timer.stop();
    
    writefln("\nProject Euler #7\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
