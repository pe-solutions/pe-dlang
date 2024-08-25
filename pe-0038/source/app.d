// Pandigital Multiples
// https://projecteuler.net/problem=38

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.array;
import std.algorithm: sort;
import std.conv: text;

bool isPandigitalConcatenation(int num) {
    auto s = text(num);
    return s.length == 9 && text(s.array.sort) == "123456789";
}

void main() {
    auto timer = StopWatch(AutoStart.yes);

    const int MAX_INDEX = 9_876;
    const MULTIPLIER = 10 ^^ 5 + 2;
    
    for (int index = MAX_INDEX; index > 0; index--) {
        int candidate = index * MULTIPLIER;

        if (isPandigitalConcatenation(candidate)) {
            writefln("\nProject Euler #38\nAnswer: %s", candidate);
            //
            break;
        }
    }

    timer.stop();
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}

