// Largest palindrome product
// https://projecteuler.net/problem=4

import std.range : iota;
import std.algorithm : cartesianProduct, filter, map, maxElement;
import euler.math : isPalindrome;
import euler.common : runSolution;

auto solve() {
    auto R = iota(899, 999+1);
    return cartesianProduct(R, R).map!(a => a[0] * a[1]).filter!isPalindrome.maxElement;
}

void main() { runSolution!(solve)(4); }
