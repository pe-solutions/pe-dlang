// Coin Sums
// https://projecteuler.net/problem=31

import euler.common : runSolution;

auto solve() {
    const TARGET = 200;
    int[] coinValues = [1, 2, 5, 10, 20, 50, 100, 200];
    int[] ways = new int[TARGET + 1];
    ways[0] = 1;
    foreach (int coin; coinValues)
        for (int i = coin; i <= TARGET; i++)
            ways[i] += ways[i - coin];
    return ways[TARGET];
}

void main() { runSolution!(solve)(31); }
