// Sub-string Divisibility
// https://projecteuler.net/problem=43

import euler.common : runSolution;

auto solve()
{
    // Check d[depth-2..depth] % p[depth-3] as each 3-digit window becomes complete.
    immutable int[7] p = [2, 3, 5, 7, 11, 13, 17];
    int[10] d;
    uint used;
    long total;

    void build(int depth)
    {
        if (depth == 10)
        {
            long n = 0;
            foreach (x; d) n = n * 10 + x;
            total += n;
            return;
        }
        foreach (dig; 0 .. 10)
        {
            if ((used >> dig) & 1) continue;
            d[depth] = dig;
            if (depth >= 3 && (d[depth-2] * 100 + d[depth-1] * 10 + dig) % p[depth-3] != 0)
                continue;
            used ^= 1u << dig;
            build(depth + 1);
            used ^= 1u << dig;
        }
    }

    build(0);
    return total;
}

void main() { runSolution!(solve)(43); }
