// Smallest Multiple
// https://projecteuler.net/problem=5

import std.range : iota;
import std.algorithm : reduce;
import std.numeric : lcm;
import euler.common : runSolution;

auto solve() { return iota(1, 20+1).reduce!lcm; }

void main() { runSolution!(solve)(5); }
