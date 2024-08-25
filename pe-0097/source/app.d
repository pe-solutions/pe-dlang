// Large Non-Mersenne Prime
// https://projecteuler.net/problem=97

import std.bigint;
import std.datetime.stopwatch: StopWatch;
import std.stdio;

long large_non_mersenne_prime(BigInt base, BigInt exponent, BigInt coeff, BigInt modulus) {
    return powmod((coeff * powmod(base, exponent, modulus) + 1), 1.BigInt, modulus).toLong;
}

void main() {
    auto timer = StopWatch(AutoStart.yes);
    
    auto answer = large_non_mersenne_prime(2.BigInt, 7_830_457.BigInt, 28_433.BigInt, 10.BigInt ^^ 10);

    timer.stop();

    writefln("\nProject Euler #97\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
