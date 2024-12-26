// Factorial Digit Sum
// https://projecteuler.net/problem=20

import std.stdio;
import std.datetime.stopwatch;

uint sum_of_digits() {    
    import std.range;
    import std.bigint;
    import std.conv;
    import std.algorithm;
    
    return reduce!"a*b"(iota(1, 100+1).map!BigInt)
        .to!string
        .map!(c => c - '0')
        .sum(0u);
}

void main()
{
    auto timer = StopWatch(AutoStart.yes);
    auto answer = sum_of_digits();
    timer.stop();
    
    writefln("\nProject Euler #20\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
