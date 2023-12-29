// Self Powers
// https://projecteuler.net/problem=48

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.bigint : BigInt, powmod;
import std.range : iota;
import std.algorithm: map, sum;

void main()
{
    StopWatch timer;
    timer.start();
    
    auto answer = powmod(iota(1, 1001).map!(i => BigInt(i) ^^ i).sum, 1.BigInt, 10.BigInt ^^ 10);
    
    timer.stop();

    writefln("\nProject Euler #48\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
