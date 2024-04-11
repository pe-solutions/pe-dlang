// Special Pythagorean Triplet
// https://projecteuler.net/problem=9

import std.stdio : writeln, writefln;
import std.datetime.stopwatch: StopWatch;
import std.typecons: tuple, Tuple;

const PERIMETER = 1_000u;

Tuple!(uint, uint, uint) findTriplet() {
    foreach (uint a; 1 .. PERIMETER/3) {
        foreach (uint b; a + 1 .. PERIMETER/2) {
            uint c = PERIMETER - a - b;
            //
            if (a * a + b * b == c * c)
                return tuple(a, b, c);
        }
    }
    //
    return tuple(0u, 0u, 0u); // No solution found
}

void main() {
    StopWatch timer;
    timer.start();

    auto result = findTriplet();

    if (result[0] != 0 && result[1] != 0 && result[2] != 0) {
        writefln("\nProject Euler #9\nAnswer: %s", result[0] * result[1] * result[2]);
    } else {
        writefln("No solution found.");
    }

    timer.stop();
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
