// Smallest Multiple
// https://projecteuler.net/problem=5

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.range: iota;
import std.algorithm: reduce;
import std.numeric: lcm;

void main() {
    StopWatch timer;
    timer.start();
    
    auto answer = iota(1, 20+1).reduce!lcm;
    
    timer.stop();
    
    writefln("\nProject Euler #5\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
