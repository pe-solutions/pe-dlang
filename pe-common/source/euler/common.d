module euler.common;

void runSolution(alias solver, int N)() {
    import std.stdio : writefln;
    import std.datetime.stopwatch : StopWatch, AutoStart;
    auto timer = StopWatch(AutoStart.yes);
    auto answer = solver();
    timer.stop();
    writefln("\nProject Euler #%d\nAnswer: %s", N, answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
