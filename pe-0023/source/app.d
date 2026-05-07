// Non-Abundant Sums
// https://projecteuler.net/problem=23

import euler.common : runSolution;

auto solve()
{
    enum int N = 28_123;

    // Additive sieve for sum of proper divisors
    auto spd = new int[N + 1];
    foreach (d; 1 .. N / 2 + 1)
        for (int m = 2 * d; m <= N; m += d)
            spd[m] += d;

    // Collect abundant numbers
    int[] abundant;
    foreach (n; 1 .. N + 1)
        if (spd[n] > n)
            abundant ~= n;

    // Mark all numbers expressible as sum of two abundant numbers
    auto canWrite = new bool[N + 1];
    foreach (i; 0 .. abundant.length)
    {
        foreach (j; i .. abundant.length)
        {
            immutable int s = abundant[i] + abundant[j];
            if (s > N) break;
            canWrite[s] = true;
        }
    }

    // Sum all positive integers that cannot be written as sum of two abundant numbers
    long total = 0;
    foreach (n; 1 .. N + 1)
        if (!canWrite[n])
            total += n;
    return total;
}

void main() { runSolution!(solve)(23); }
