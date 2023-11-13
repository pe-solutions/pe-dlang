// Multiple of 3 or 5
// https://projecteuler.net/problem=1

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.range : iota;
import std.algorithm : filter, sum;
import std.numeric;

void main() {
    StopWatch timer;
    timer.start();
    
    auto answer = iota(1,999+1).filter!(a => gcd(a,3*5)>1).sum;
    
    timer.stop();
        
    writefln("\nProject Euler #1\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
