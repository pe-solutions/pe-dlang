// Number Spiral Diagonals
// https://projecteuler.net/problem=28

import std.stdio;
import std.datetime.stopwatch: StopWatch;

/// Closed form
long sumOfSpiralDiagonals(const long n) =>
    (4L * n ^^ 3L + 3L * n ^^ 2L + 8L * n - 9L) / 6L;

void main()
{
    auto timer = StopWatch(AutoStart.yes);

    // Size of the spiral
    const SIZE = 1_001L;
    
    auto answer = sumOfSpiralDiagonals(SIZE);
    
    timer.stop();
    
    writefln("\nProject Euler #28\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
