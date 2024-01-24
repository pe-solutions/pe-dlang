// Even Fibonacci Numbers
// https://projecteuler.net/problem=2

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.range : recurrence;
import std.algorithm.searching : until;
import std.algorithm : filter, sum;

void main()
{
    StopWatch timer;
    timer.start();
    
    auto fib = recurrence!("a[n-1] + a[n-2]")(1uL, 1uL);
    
    auto answer = fib
        .until!(x => x >= 4_000_000uL)
        .filter!(x => x % 2uL == 0uL)
        .sum;

    timer.stop();
        
    writefln("\nProject Euler #2\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());

}
