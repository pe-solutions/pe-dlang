// Amicable Chains
// https://projecteuler.net/problem=95

import euler.common : runSolution;

auto solve() {
    enum int N = 1_000_000;

    // Sum of proper divisors for every n in [0, N] via additive sieve.
    auto spd = new int[N + 1];
    foreach (d; 1 .. N / 2 + 1)
        for (int m = 2 * d; m <= N; m += d)
            spd[m] += d;

    // Follow chains and detect cycles.
    // visited[n]: 0 = unvisited, -1 = processed, k>0 = step k in current path.
    auto visited = new int[N + 1];
    auto path    = new int[N + 1];  // pre-allocated; avoids GC churn
    int bestLen = 0, bestMin = 0;

    foreach (start; 2 .. N + 1) {
        if (visited[start] != 0) continue;

        int pathLen = 0;
        int n = start, step = 1;

        while (n >= 2 && n <= N && visited[n] == 0) {
            visited[n] = step++;
            path[pathLen++] = n;
            n = spd[n];
        }

        // n is in the current path → cycle found; visited[n]-1 is its 0-based index.
        if (n >= 2 && n <= N && visited[n] > 0) {
            immutable int cycleStart = visited[n] - 1;
            immutable int cycleLen   = pathLen - cycleStart;
            if (cycleLen > bestLen) {
                bestLen = cycleLen;
                int cmin = int.max;
                foreach (i; cycleStart .. pathLen)
                    if (path[i] < cmin) cmin = path[i];
                bestMin = cmin;
            }
        }

        foreach (i; 0 .. pathLen) visited[path[i]] = -1;
    }

    return bestMin;
}

void main() { runSolution!(solve)(95); }
