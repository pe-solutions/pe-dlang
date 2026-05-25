// Digit Factorial Chains
// https://projecteuler.net/problem=74

import euler.common : runSolution;

auto solve() {
    import euler.math : digitFactSum;
    enum int N      = 1_000_000;
    enum int MAXVAL = 2_200_000; // max digitFactSum for any n < N is 6*9! = 2,177,280

    auto cache = new int[MAXVAL + 1]; // 0 = not yet computed; else chain length
    int[100] path;

    int result = 0;
    foreach (int start; 1 .. N) {
        if (cache[start] != 0) {
            if (cache[start] == 60) ++result;
            continue;
        }

        int plen = 0, k = -1;
        int cur = start;

        // Walk chain until we hit a cached value or revisit a node (cycle).
        while (cur <= MAXVAL && cache[cur] == 0) {
            k = -1;
            foreach (i; 0 .. plen)
                if (path[i] == cur) { k = i; break; }
            if (k >= 0) break;
            path[plen++] = cur;
            cur = digitFactSum(cur);
        }

        if (k >= 0) {
            // Cycle: path[k..plen) form a cycle of length plen-k.
            immutable int cycleLen = plen - k;
            foreach (j; k .. plen) cache[path[j]] = cycleLen;
            foreach (j; 0 ..  k) cache[path[j]] = plen - j;
        } else {
            // Tail leading into cached node cur with known chain length c.
            immutable int c = (cur <= MAXVAL) ? cache[cur] : 1;
            foreach (j; 0 .. plen) cache[path[j]] = (plen - j) + c;
        }

        if (cache[start] == 60) ++result;
    }
    return result;
}

void main() { runSolution!(solve)(74); }
