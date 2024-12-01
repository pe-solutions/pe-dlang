// The Tournament
// https://projecteuler.net/problem=849

import std.stdio;
import std.traits : isIntegral;
import std.datetime.stopwatch: AutoStart, StopWatch;
import std.algorithm: max;

T mod(T)(T a, T b) if (isIntegral!T) {
    return (a % b + b) % b;
}

long f_alternate(long numIterations, long moduloValue) {
    long maxs = 2 * numIterations * (numIterations - 1);
    long maxd = 4 * (numIterations - 1);

    long[][] dp;

    foreach (i; 0 .. numIterations + 1)
        dp ~= new long[maxs + 1];

    dp[0][0] = 1;

    for (long d = 0; d <= maxd; ++d) {
        for (long i = 1; i <= numIterations; ++i) {
            for (long s = max(d, 2 * i * (i - 1)); s <= maxs; ++s) {
                dp[i][s] = mod(dp[i][s] + dp[i - 1][s - d], moduloValue);
            }
        }
    }

    return dp[numIterations][maxs];
}

void main() {
    auto timer = StopWatch(AutoStart.yes);

    const long N = 100;
    const long MODULO = 10^^9 + 7;
    
    auto answer = f_alternate(N, MODULO);
    
    timer.stop();

    writefln("\nProject Euler #849\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
