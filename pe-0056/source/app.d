import std.stdio;
import std.datetime.stopwatch;
import std.algorithm;
import std.bigint;
import std.range;
import std.conv;

void main() {
    auto timer = StopWatch(AutoStart.yes);
    
    "\nProject Euler #56\nAnswer: %s".writefln(iota(1, 100)
        .cartesianProduct(iota(1, 100))
        .map!(ab => BigInt(ab[0])^^ab[1])
        .map!(n => n.to!string.map!(c => c - '0').sum)
        .maxElement);
    
    timer.stop;
    
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"()); 
}
