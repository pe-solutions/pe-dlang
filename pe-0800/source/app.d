// Hybrid Integers
// https://projecteuler.net/problem=800

import std.stdio;
import std.datetime.stopwatch;
import std.math;
import std.container.array;

int[] sieve(int n) {
    auto isPrime = new bool[n + 1];
    
    isPrime[2..$] = true;

    int sqrtN = cast(int) sqrt(cast(float) n) + 1;
    
    for (int i = 2; i < sqrtN; ++i) {
        if (isPrime[i]) {
            for (int j = i * i; j <= n; j += i) {
                isPrime[j] = false;
            }
        }
    }

    auto primes = new Array!int;
    
    for (int i = 2; i <= n; ++i) {
        if (isPrime[i])
            primes.insertBack(i);
    }

    return primes.data[].dup;
}

bool isValid(double p, double q, double b, double e) {
    return pow(p, q / e) * pow(q, p / e) <= b;
}

int count_hybrid_integers(int base, int exponent) {
    auto primes = sieve(16_000_000);
    
    int count = 0;
    
    for (int p = 0; p + 1 < primes.length; ++p) {
        for (int q = p + 1; q < primes.length; ++q) {
            if (isValid(primes[p], primes[q], base, exponent)) {
                count += 1;
            } else {
                // inner Loop bound
                break;
            }
        }
        
        if (!isValid(primes[p], 2.0, base, exponent)) {
            // outer Loop bound
            break;
        }
    }
    
    return count; // 0;
}

void main() {
    StopWatch timer;
    timer.start();
    //
    
    const int BASE = 800_800;
    const int EXPONENT = 800_800;

    auto answer = count_hybrid_integers(BASE, EXPONENT);
    
    //
    timer.stop();

    writefln("\nProject Euler #800\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}