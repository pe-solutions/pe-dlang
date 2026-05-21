// Pandigital Products
// https://projecteuler.net/problem=32

import std.algorithm : filter, sum;
import std.range    : iota;
import euler.common : runSolution;

// Returns a bitmask with bit d set for each digit d of n (d = 1-9).
// Returns 0 if any digit is 0 or appears more than once.
uint digitMask(int n) pure nothrow @nogc
{
    uint mask = 0;
    while (n > 0)
    {
        immutable d = n % 10;
        if (d == 0 || (mask >> d) & 1) return 0;
        mask |= 1u << d;
        n /= 10;
    }
    return mask;
}

auto solve()
{
    // Total digits across a, b, c must equal 9: valid splits are 1+4+4 and 2+3+4.
    // Masks must be disjoint and cover bits 1-9 exactly: sum == 0x3FE.
    enum uint full = 0x3FEu;
    bool[10_000] seen;

    // 1-digit × 4-digit = 4-digit
    foreach (a; 1 .. 10)
    {
        immutable ma = digitMask(a);
        foreach (b; 1_000 .. 10_000)
        {
            immutable c = a * b;
            if (c >= 10_000) break;
            if (ma + digitMask(b) + digitMask(c) == full)
                seen[c] = true;
        }
    }

    // 2-digit × 3-digit = 4-digit
    foreach (a; 10 .. 100)
    {
        immutable ma = digitMask(a);
        if (!ma) continue;
        foreach (b; 100 .. 1_000)
        {
            immutable c = a * b;
            if (c >= 10_000) break;
            if (ma + digitMask(b) + digitMask(c) == full)
                seen[c] = true;
        }
    }

    return iota(1_000, 10_000).filter!(i => seen[i]).sum;
}

void main() { runSolution!(solve)(32); }
