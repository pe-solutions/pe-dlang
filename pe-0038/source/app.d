// Pandigital Multiples
// https://projecteuler.net/problem=38

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.array: array;
import std.algorithm: sort;
import std.conv: to;

bool isPanDigital(int num) {
	auto s = num.to!string;
	//
    return s.length == 9 &&  to!string(s.array.sort) == "123456789";
}

void main()
{
    StopWatch timer;
    timer.start();

	for (int index = 9876; true; index--)
    {
        int candidate = index * (10^^5 + 2);

        if (isPanDigital(candidate))
        {
            writefln("\nProject Euler #38\nAnswer: %s", candidate);
			//
            break;
        }
    }

	timer.stop();

	writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
