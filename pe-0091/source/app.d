// Right Triangles with Integer Coordinates
// https://projecteuler.net/problem=91

import std.stdio;
import std.range;
import std.datetime.stopwatch;
import std.algorithm;

bool isValidTuple(int k1, int k2, int l1, int l2)
{
    return k1 * l2 != k2 * l1 &&
           (k1 * k1 + k2 * k2 == k1 * l1 + k2 * l2 ||
            l1 * l1 + l2 * l2 == k1 * l1 + k2 * l2 ||
            k1 * l1 + k2 * l2 == 0);
}

ulong count_triangles(int n)
{
    auto ranges = iota(0, n + 1);

    auto count = cartesianProduct(ranges, ranges, ranges, ranges)
        .filter!(t => isValidTuple(t[0], t[1], t[2], t[3]))
        .count;

    return count/2;
}

void main()
{
    auto timer = StopWatch(AutoStart.yes);
    
    auto answer = count_triangles(50);
    
    timer.stop();

    writefln("\nProject Euler #91\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
