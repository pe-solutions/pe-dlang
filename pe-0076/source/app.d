// Counting Summations
// https://projecteuler.net/problem=76

import std.stdio;
import std.datetime.stopwatch: StopWatch;

size_t computePartitions(int n) {
    auto partitions = new size_t[n + 1];
    partitions[0] = 1;

    foreach (i; 1 .. n + 1) {
        foreach (j; i .. n + 1) {
            partitions[j] += partitions[j - i];
        }
    }

    return partitions[n];
}

size_t nPartitions(int n) {
    return computePartitions(n) - 1;
}


void main() {
    auto timer = StopWatch(AutoStart.yes);
    
    const int N = 100;
    auto answer = nPartitions(N);
    
    timer.stop();

    writefln("\nProject Euler #76\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
