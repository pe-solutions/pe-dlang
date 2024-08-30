// Counting Sundays
// https://projecteuler.net/problem=19

import std.stdio;
import std.datetime.stopwatch;
import std.datetime;
import std.range;
import std.algorithm;

auto pe0019() {
    // Compute the Cartesian product of years and months
    auto yearMonthPairs = cartesianProduct(iota(1901, 2001), iota(Month.jan, Month.dec + 1));

    // Count the number of Sundays on the first of the month
    return yearMonthPairs
        .filter!(pair => Date(pair[0], pair[1], 1).dayOfWeek == DayOfWeek.sun)
        .count;
}

void main() {
    auto timer = StopWatch(AutoStart.yes);
    auto answer = pe0019();
    timer.stop();
        
    writefln("\nProject Euler #19\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}

