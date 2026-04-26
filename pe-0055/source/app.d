// Lychrel Numbers
// https://projecteuler.net/problem=55

import euler.math : isPalindrome, reverseDigits;
import euler.common : runSolution;

bool isLychrel(long number) {
    long temp = number;
    for (long iteration = 1; iteration <= 50; iteration++) {
        temp += reverseDigits(temp);
        if (isPalindrome(temp)) return false;
    }
    return true;
}

auto solve() {
    int total = 0;
    for (long n = 1; n <= 10_000; n++)
        if (isLychrel(n)) total++;
    return total;
}

void main() { runSolution!(solve, 55)(); }
