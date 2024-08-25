// Coin Sums
// https://projecteuler.net/problem=31

import std.stdio;
import std.datetime.stopwatch: StopWatch;

void main()
{
    auto timer = StopWatch(AutoStart.yes);

    // Dynamic Programming
    
    const TARGET = 200;
    
    int[] coinValues = [1, 2, 5, 10, 20, 50, 100, 200];
    int[] ways = new int[TARGET + 1];
    
    ways[0] = 1;

    foreach (int coin; coinValues)
    {
        for (int i = coin; i <= TARGET; i++)
        {
            ways[i] += ways[i - coin];
        }
    }
    
    auto answer = ways[TARGET];
    
    timer.stop();

    writefln("\nProject Euler #31\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
