// Integer Right Triangles
// https://projecteuler.net/problem=39

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;

void main() {
    auto timer = StopWatch(AutoStart.yes);

    int maxPerimeter = 0;
    int maxCount = 0;

    foreach (int p; 12 .. 1001) {
        int count = 0;

        foreach (int b; 2 .. p / 2) {
            foreach (int a; 1 .. b) {
                int c = p - (a + b);

                // Check for a right-angled triangle 
                // `c > a` is implicit since c is determined as p - (a + b)
                if (a * a + b * b == c * c && c > b) {
                    count++;
                }
            }
        }

        // Update maxCount and maxPerimeter if a new maximum is found
        if (count > maxCount) {
            maxCount = count;
            maxPerimeter = p;
        }
    }

    auto answer = maxPerimeter;

    timer.stop();

    writefln("\nProject Euler #39\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
