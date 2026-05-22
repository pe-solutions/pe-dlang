// Pandigital Prime Sets
// https://projecteuler.net/problem=118

import euler.common : runSolution;

auto solve() {
    import euler.math : isPrime;

    // For each digit-subset mask (bit i ↔ digit i+1, 0 ≤ i < 9), enumerate every
    // permutation of those digits and record the primes formed.
    long[][] byMask = new long[][512];
    foreach (mask; 1 .. 512) {
        int[] digs;
        foreach (i; 0 .. 9)
            if (mask & (1 << i)) digs ~= i + 1;
        void gen(int k) {
            if (k == cast(int)digs.length) {
                long n = 0;
                foreach (d; digs) n = n * 10 + d;
                if (isPrime(n)) byMask[mask] ~= n;
                return;
            }
            foreach (i; k .. cast(int)digs.length) {
                int t = digs[k]; digs[k] = digs[i]; digs[i] = t;
                gen(k + 1);
                t = digs[k]; digs[k] = digs[i]; digs[i] = t;
            }
        }
        gen(0);
    }

    // Partition all 9 digit-bits into prime-forming subsets.
    // Always consume the lowest available bit first — each unordered partition
    // is visited exactly once; each distinct prime from byMask[m] is a separate set.
    long count = 0;
    void search(int avail) {
        if (avail == 0) { ++count; return; }
        immutable low  = avail & -avail;
        immutable rest = avail ^ low;
        for (int sub = rest; ; sub = (sub - 1) & rest) {
            foreach (_; 0 .. byMask[sub | low].length)
                search(avail ^ (sub | low));
            if (sub == 0) break;
        }
    }

    search(0x1FF);
    return count;
}

void main() { runSolution!(solve)(118); }
