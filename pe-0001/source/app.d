// Multiples of 3 or 5
// https://projecteuler.net/problem=1

import std.stdio;
import std.datetime.stopwatch: StopWatch;
import std.range;
import std.algorithm;

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
    
    auto answer =  solve([5, 3], 999+1);
    
    timer.stop();
    
    writefln("\nProject Euler #1\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
