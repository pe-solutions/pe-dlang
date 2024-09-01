// Powerful Digit Counts
// https://projecteuler.net/problem=63

import std.stdio;
import std.datetime.stopwatch;
import std.math;

void main() {
     auto timer = StopWatch(AutoStart.yes);

    int totalCount = 0;

    foreach (i; 1 .. 10) {
        real log_i = log10(cast(real)i);
        int count = cast(int) floor(1.0 / (1.0 - log_i));
        
        totalCount += count;
    }

    timer.stop();
    
    writefln("\nProject Euler #63\nAnswer: %s", totalCount);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
