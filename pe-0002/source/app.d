// Even Fibonacci Numbers
// https://projecteuler.net/problem=2

import std.stdio: writefln;
import std.datetime.stopwatch: StopWatch;
import std.range: recurrence, take;
import std.algorithm: sum;
import std.algorithm.searching: until;

static ulong genEvenFibonacci(R)(R state, size_t n)
{
    return 4 * state[n-1] + state[n-2];
}
    
void main()
{
    StopWatch timer;
    timer.start();
    
    auto evenfib = recurrence!genEvenFibonacci(2uL, 8uL);
    
    const ulong UPPER_LIMIT = 4_000_000uL;

    auto answer = evenfib.until!(n => n > UPPER_LIMIT).sum;

    timer.stop();
    
    writefln("\nProject Euler #2\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
