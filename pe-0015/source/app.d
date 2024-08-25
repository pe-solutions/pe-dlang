// Lattice Paths
// https://projecteuler.net/problem=15

import std.stdio: writefln;
import std.datetime.stopwatch: StopWatch;
import std.range: iota;
import std.algorithm.iteration: reduce;

void main() {
    auto timer = StopWatch(AutoStart.yes);
    
    alias countRoutes = (int n) => reduce!((a, b) => a * (n + b) / b)(1L, iota(1, n + 1));
    
    const int N = 20;
    auto answer = countRoutes(N);
    
    timer.stop();
    
    writefln("\nProject Euler #15\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
