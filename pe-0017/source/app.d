// Number Letter Counts
// https://projecteuler.net/problem=17

import std.algorithm : map, sum;
import std.range     : iota;
import euler.common  : runSolution;

// Letter counts for 0-19 and for the tens (20,30,...,90).
static immutable int[20] ones = [0,3,3,5,4,4,3,5,5,4, 3,6,6,8,8,7,7,9,8,8];
static immutable int[10] tens = [0,0,6,6,5,5,5,7,6,6];

int letterCount(int n) {
    if (n == 1000) return 11;                          // "onethousand"
    if (n >= 100) {
        int h = ones[n / 100] + 7;                     // "X hundred"
        int r = n % 100;
        return r == 0 ? h : h + 3 + letterCount(r);   // + "and"
    }
    if (n >= 20) return tens[n / 10] + ones[n % 10];
    return ones[n];
}

auto solve() {
    return iota(1, 1001).map!letterCount.sum;
}

void main() { runSolution!(solve)(17); }
