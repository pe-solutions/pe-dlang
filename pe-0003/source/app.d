// Largest Prime Factor
// https://projecteuler.net/problem=3

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;

T largestPrimeFactor(T)(in T n) pure nothrow {
	T limit = n / 2;
	T retval = n;
	
	for (T i = 3; i < limit; i += 2) {
		for (T k = retval; k % i == 0; retval = k) {
			k = k / i;
			limit = k / 2;
		}
	}
	
	return retval;
}

void main() {
    auto timer = StopWatch(AutoStart.yes);
    
    auto answer = 600_851_475_143.largestPrimeFactor;

    timer.stop();
        
    writefln("\nProject Euler #3\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
