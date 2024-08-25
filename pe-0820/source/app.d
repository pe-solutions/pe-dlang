// Nth Digit of Reciprocals
// https://projecteuler.net/problem=820

import std.stdio: writefln;
import std.datetime.stopwatch: StopWatch;
import std.range: iota;
import std.math: powmod;
import std.algorithm: map, sum;

void main() {
    auto timer = StopWatch(AutoStart.yes);
    
    ulong n = 10_000_000;
    
    auto answer = iota(1UL, n + 1).map!(k => powmod(10UL, n, 10UL * k) / k).sum;
    
    timer.stop();
    
    writefln("\nProject Euler #820\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
