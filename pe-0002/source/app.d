// Even Fibonacci Numbers
// https://projecteuler.net/problem=2

// Even Fibonacci Numbers
// https://projecteuler.net/problem=2

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;

void main() {
    StopWatch timer;
    timer.start();
    
    const UPPERLIMIT = 4_000_000;
    
    int a = 1;
    int b = 1;
    
    int answer = 0;
    
    while (a < UPPERLIMIT)
    {
        int next = a + b;
        
        a = b;
        b = next;
        
        if (b % 2 == 0)
        {
            answer += b;
        }
    }
    
    timer.stop();
        
    writefln("\nProject Euler #2\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
