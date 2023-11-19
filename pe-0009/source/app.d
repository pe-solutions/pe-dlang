// Special Pythagorean Triplet
// https://projecteuler.net/problem=9

import std.stdio : writeln, writefln;
import std.datetime.stopwatch: StopWatch;
import std.typecons: tuple, Tuple;

const P = 1_000u;

Tuple!(uint, uint, uint) findTriplet() {
    for (uint a = 1; a < P / 3; a++) {
        // Calculate numerator (n) and denominator (d)
        int n = P^^2 - 2 * P * a;
        int d = 2 * P - 2 * a;

        // Check if n is divisible evenly by d
        if (d != 0 && n % d == 0)
        {
            // Calculate b and c based on conditions
            uint b = n / d;
            uint c = P - a - b;

            return tuple(a, b, c);
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

