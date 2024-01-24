// Multiples of 3 or 5
// https://projecteuler.net/problem=1

import std.stdio;
import std.datetime.stopwatch: StopWatch;
import std.range: iota;
import std.algorithm: any, filter, sum;

int solve(int[] multiples, int limit)
{
    return iota(1, limit)
        .filter!(n => multiples.any!(m => n % m == 0))
        .sum;
}

void main()
{
    StopWatch timer;
    timer.start();
    
    auto answer =  solve([3, 5], 1_000);
    
    timer.stop();
    
    writefln("\nProject Euler #1\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
