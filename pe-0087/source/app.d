// Prime Power Triples
// https://projecteuler.net/problem=87

import euler.math : sieve;
import euler.common : runSolution;

auto solve() {
    enum int limit = 50_000_000;
    auto isPrime = sieve(7071);

    int[] ps;
    foreach (p; 2 .. 7072) if (isPrime[p]) ps ~= p;

    auto seen = new bool[limit];
    int count = 0;

    foreach (a; ps) {
        immutable long a2 = cast(long)a * a;
        if (a2 >= limit) break;
        foreach (b; ps) {
            immutable long b3 = cast(long)b * b * b;
            if (a2 + b3 >= limit) break;
            foreach (c; ps) {
                immutable long c4 = cast(long)c * c * c * c;
                immutable long total = a2 + b3 + c4;
                if (total >= limit) break;
                if (!seen[cast(int)total]) { seen[cast(int)total] = true; ++count; }
            }
        }
    }
    return count;
}

void main() { runSolution!(solve)(87); }
