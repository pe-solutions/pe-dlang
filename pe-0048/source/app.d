// Self Powers
// https://projecteuler.net/problem=48

import std.stdio;
import std.datetime.stopwatch: StopWatch;

ulong sum_of_self_power(ulong n, ulong modulus) {
    ulong result = 0;

    for (int i = 1; i <= n; ++i) {
        ulong f = i;

        for (int j = 1; j < i; ++j) {
            f = (f * i) % modulus;
        }

        result = (result + f) % modulus;
    }

    return result;
}

void main() {
    StopWatch timer;
    timer.start();
    
    const ulong N = 1000uL;
    const ulong MOD = 10uL^^10;

    ulong answer = sum_of_self_power(N, MOD);

    timer.stop();

    writefln("\nProject Euler #48\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}

