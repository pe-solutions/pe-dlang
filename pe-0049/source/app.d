// Prime Permutations
// https://projecteuler.net/problem=49

import std.stdio;
import std.datetime.stopwatch: StopWatch;
import std.algorithm;
import std.array;
import std.conv;

bool isprime(ulong n) {
    if (n < 2) {
        return false;
    }

    foreach (i; 2 .. n) {
        if (n % i == 0) {
            return false;
        }
    }

    return true;
}

bool ispermutation(ulong a, ulong b) {
    auto str_a = to!string(a).array.sort;
    auto str_b = to!string(b).array.sort;

    return equal(str_a, str_b);
}

ulong findPrimePermutations() {
    const ulong STEP = 3330;
    
    ulong a, b, c;

    for (a = 1487 + 1; a <= STEP + 1; a++) {
        b = a + STEP;
        c = b + STEP;

        if (isprime(a) && isprime(b) && isprime(c) && ispermutation(a, b) && ispermutation(b, c)) {
            return 10^^(2 * 4) * a + 10^^4 * b + c;
        }
    }

    return 0;
}

void main() {
    StopWatch timer;
    timer.start();

    auto answer = findPrimePermutations();

    timer.stop();

    writefln("\nProject Euler #49\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
