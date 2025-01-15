// Multiples of 3 or 5
// https://projecteuler.net/problem=1

import std.stdio;
import std.datetime.stopwatch: AutoStart, StopWatch;
import std.range: iota;
import std.algorithm: any, filter, sum;

int getSumOfMultiples(int[] multiples, int limit)
{
    return iota(1, limit)
        .filter!(n => multiples.any!(m => n % m == 0))
        .sum;
}

void main()
{
    auto timer = StopWatch(AutoStart.yes);
    
    auto answer =  getSumOfMultiples([3, 5], 1_000);
    
    timer.stop();
    
    writefln("\nProject Euler #1\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
