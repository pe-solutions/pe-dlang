module euler.common;

void runSolution(alias solver)(int N) {
    import std.stdio : writefln;
    import std.datetime.stopwatch : StopWatch, AutoStart;
    auto sw = StopWatch(AutoStart.yes);
    auto answer = solver();
    immutable elapsed = sw.peek;
    sw.stop();
    writefln("\nProject Euler #%d\nAnswer: %s\nElapsed time: %s milliseconds.\n", N, answer, elapsed.total!"msecs");
}
