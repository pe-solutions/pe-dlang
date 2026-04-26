// Powers with Trailing Digits
// https://projecteuler.net/problem=455

import std.stdio : writefln;
import std.datetime.stopwatch : StopWatch, AutoStart;
import std.math : powmod;

void main() {
    auto timer = StopWatch(AutoStart.yes);

    ulong totalSum = 0;

    for (ulong number = 2; number <= 1000000; number += !(++number % 10)) {
        ulong current, next;

        for (current = number; ; current = next) {
            next = powmod(number, current, 1000000000UL);
            if (next == current) break;
        }

        totalSum += current;
    }

    timer.stop();

    writefln("\nProject Euler #455\nAnswer: %s", totalSum);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
