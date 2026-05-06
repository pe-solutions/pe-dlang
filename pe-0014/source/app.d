// Longest Collatz Sequence
// https://projecteuler.net/problem=14

import euler.common : runSolution;

ulong computeCollatzLength(ulong n, ulong[ulong] lengths) {
    ulong length = 0;
    ulong num = n;
    while (num != 1) {
        if (num in lengths) {
            length += lengths[num];
            break;
        }
        num = num % 2 == 0 ? num / 2 : 3 * num + 1;
        length += 1;
    }
    lengths[n] = length;
    return length;
}

auto solve() {
    const ulong MAX_NUMBER = 1_000_000;
    ulong[ulong] lengths;
    lengths[1] = 1;
    ulong longestSequence = 1;
    ulong maxLength = 1;
    foreach (i; 2 .. MAX_NUMBER + 1) {
        auto length = computeCollatzLength(i, lengths);
        if (length > maxLength) {
            longestSequence = i;
            maxLength = length;
        }
    }
    return longestSequence;
}

void main() { runSolution!(solve)(14); }
