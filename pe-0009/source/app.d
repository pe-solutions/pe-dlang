// Special Pythagorean Triplet
// https://projecteuler.net/problem=9

import std.stdio : writeln, writefln;
import std.datetime.stopwatch: StopWatch;
import std.typecons: tuple, Tuple;

Tuple!(uint, uint, uint) findTriplet() {
    for (uint a = 1; a < 334; a++) {
        for (uint b = a + 1; b < (1000 - a) / 2; b++) {
            auto c = 1000 - a - b;
            //
            if (a * a + b * b == c * c) {
                return tuple(a, b, c);
            }
        }
    }

    return tuple(0u, 0u, 0u); // No solution found
}

void main() {
    StopWatch timer;
    timer.start();

    auto result = findTriplet();

    if (result[0] != 0) {
        writefln("\nProject Euler #9\nAnswer: %s", result[0] * result[1] * result[2]);
    } else {
        writefln("No solution found.");
    }

    timer.stop();
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
