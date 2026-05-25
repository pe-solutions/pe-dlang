// Dice Box
// https://projecteuler.net/problem=997

import euler.common : runSolution;

// Factored — 3·(2^x + 2^y + 2^z − 4)·2^(x+y+z−1)
private ulong solveFactored(ulong x, ulong y, ulong z) pure nothrow @nogc
{
    return 3UL * (((1UL << x) + (1UL << y) + (1UL << z) - 4UL) * (1UL << (x + y + z - 1)));
}

// Shifted — 3·2^(x+y+z)·(2^(x−1) + 2^(y−1) + 2^(z−1) − 2)
private ulong solveShifted(ulong x, ulong y, ulong z) pure nothrow @nogc
{
    return 3UL * (1UL << (x + y + z)) * ((1UL << (x - 1)) + (1UL << (y - 1)) + (1UL << (z - 1)) - 2UL);
}

// Expanded — 3·(2^(2x+y+z−1) + 2^(x+2y+z−1) + 2^(x+y+2z−1) − 2^(x+y+z+1))
private ulong solveExpanded(ulong x, ulong y, ulong z) pure nothrow @nogc
{
    return 3UL * ((1UL << (2*x + y + z - 1)) + (1UL << (x + 2*y + z - 1)) + (1UL << (x + y + 2*z - 1)) - (1UL << (x + y + z + 1)));
}

auto solve()
{
    enum ulong x = 9, y = 10, z = 11;
    immutable result = solveFactored(x, y, z);                           // preferred
    assert(solveShifted(x, y, z)  == result, "solveShifted disagrees");  // stripped by -release
    assert(solveExpanded(x, y, z) == result, "solveExpanded disagrees"); // stripped by -release
    return result; // 5765993594880
}

void main() { runSolution!(solve)(997); }
