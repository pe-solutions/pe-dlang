// Sum Square Difference
// https://projecteuler.net/problem=6

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.range: iota;
import std.algorithm: map, sum;

void main() {
    auto timer = StopWatch(AutoStart.yes);
    
    auto answer = iota(1, 100+1).sum ^^ 2 - iota(1, 100+1).map!(a => a ^^ 2).sum;
    
    timer.stop();
    
    writefln("\nProject Euler #6\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
