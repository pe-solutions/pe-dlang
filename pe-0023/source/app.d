// Non-Abundant Sums
// https://projecteuler.net/problem=23

import std.range : assumeSorted;
import euler.common : runSolution;

auto solve()
{
    enum int N = 28_123;

    // Additive sieve for sum of proper divisors
    auto spd = new int[N + 1];
    foreach (d; 1 .. N / 2 + 1)
        for (int m = 2 * d; m <= N; m += d)
            spd[m] += d;

    // Collect abundant numbers — count first to avoid GC realloc
    int count = 0;
    foreach (n; 1 .. N + 1)
        if (spd[n] > n) ++count;
    auto abundant = new int[count];
    int idx = 0;
    foreach (n; 1 .. N + 1)
        if (spd[n] > n) abundant[idx++] = n;

    // Mark all numbers expressible as sum of two abundant numbers.
    // Binary search gives the last valid j without a per-iteration branch.
    auto canWrite = new bool[N + 1];
    auto sorted = abundant.assumeSorted;
    foreach (i, ai; abundant)
    {
        immutable int limit = N - ai;
        if (limit < ai) break;
        auto tail = abundant[i .. $];
        immutable size_t end = tail.assumeSorted.upperBound(limit).length;
        foreach (aj; tail[0 .. $ - end])
            canWrite[ai + aj] = true;
    }

    // N*(N+1)/2 minus the sum of expressible numbers
    long total = cast(long) N * (N + 1) / 2;
    foreach (n; 1 .. N + 1)
        if (canWrite[n]) total -= n;
    return total;
}

void main() { runSolution!(solve)(23); }
