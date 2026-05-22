// Cubic Permutations
// https://projecteuler.net/problem=62

import euler.common : runSolution;

auto solve() {
    import euler.math : digitFreq;
    long[ulong] cnt;
    long[ulong] smallest;

    for (long n = 1; ; ++n) {
        immutable long cube = n * n * n;
        immutable ulong key = digitFreq(cube);
        if (key !in cnt) {
            cnt[key] = 1;
            smallest[key] = cube;
        } else if (++cnt[key] == 5) {
            return smallest[key];
        }
    }
}

void main() { runSolution!(solve)(62); }
