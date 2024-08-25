// Champernowne's Constant
// https://projecteuler.net/problem=40

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.range : array, iota;
import std.algorithm : joiner, map;
import std.conv : to;

void main() {
    auto timer = StopWatch(AutoStart.yes);
	
    auto c = iota(1, 250_000+1)
        .map!(x => to!string(x)
                     .map!(c => c.to!int - '0')
                     .array)
        .joiner
        .array;
    
    auto answer = c[0] * c[9] * c[99] * c[999] * c[9_999] * c[99_999] * c[999_999];
	
    timer.stop();
        
    writefln("\nProject Euler #40\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
