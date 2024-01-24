// Even Fibonacci Numbers
// https://projecteuler.net/problem=2

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;

ulong calcSumOfEvenFibo(ulong limit)
{
    ulong sum = 0;
    
    ulong x = 1, y = 1;
    
    do
    {
        auto currentEven = x + y;
        
        if (currentEven > limit)
            break;
        
        sum += currentEven;
        
        x = y + currentEven;
        y = x + currentEven;
    } while (true);

    return sum;
}

void main()
{
    StopWatch timer;
    timer.start();
    
    const UPPER_LIMIT = 4_000_000;
    
    auto answer = calcSumOfEvenFibo(UPPER_LIMIT);
    
    timer.stop();
        
    writefln("\nProject Euler #2\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
