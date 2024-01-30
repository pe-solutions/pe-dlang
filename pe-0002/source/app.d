// Even Fibonacci Numbers
// https://projecteuler.net/problem=2

import std.stdio: writefln;
import std.datetime.stopwatch: StopWatch;
import std.range: recurrence;
import std.algorithm.searching : until;
import std.algorithm: sum;

ulong calculateSumOfEvenFibo(ulong limit)
{
    auto evenNumberedTermFib = recurrence!("4*a[n-1] + a[n-2]")(2uL, 8uL);
    
    return evenNumberedTermFib
        .until!(x => x >= limit)
        .sum;
}

void main()
{
    StopWatch timer;
    timer.start();
    
    const ulong UPPER_LIMIT = 4_000_000uL;
    
    auto answer = calculateSumOfEvenFibo(UPPER_LIMIT);
    
    timer.stop();
    
    writefln("\nProject Euler #2\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
