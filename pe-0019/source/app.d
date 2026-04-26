// Counting Sundays
// https://projecteuler.net/problem=19

import std.datetime : Date, DayOfWeek, Month;
import std.range : iota;
import std.algorithm : cartesianProduct, filter, count;
import euler.common : runSolution;

auto solve() {
    return cartesianProduct(iota(1901, 2001), iota(Month.jan, Month.dec + 1))
        .filter!(pair => Date(pair[0], pair[1], 1).dayOfWeek == DayOfWeek.sun)
        .count;
}

void main() { runSolution!(solve, 19)(); }
