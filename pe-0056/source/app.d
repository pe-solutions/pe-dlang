// Powerful Digit Sum
// https://projecteuler.net/problem=56

import std.stdio;
import std.datetime.stopwatch;
import std.range;
import std.bigint;
import std.algorithm;
import std.conv;

void main() {
    auto timer = StopWatch(AutoStart.yes);
    
    // Generate range of values for a and b
    auto rangeA = iota(1, 100);
    auto rangeB = iota(1, 100);

    // Compute maximum digital sum
    auto maxDigitalSum = rangeA
        .cartesianProduct(rangeB)       // Generate all pairs (a, b)
        .map!(ab => BigInt(ab[0])^^ab[1])  // Calculate a^b for each pair
        .map!(n => n.to!string          // Convert to string
                      .map!(c => c-'0') // Convert digits to integers
                      .reduce!"a + b")  // Sum the digits
        
        .reduce!"max(a, b)";            // Find the maximum digital sum

    timer.stop();
    
    writefln("\nProject Euler #56\nAnswer: %s", maxDigitalSum);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());    
}
