// Magic 5-gon Ring
// https://projecteuler.net/problem=68

import euler.common : runSolution;

auto solve() {
    import std.conv : to;
    string maxStr;
    int[5] inner;

    // Enumerate all ordered 5-tuples from {1..9} as the inner pentagon.
    // 10 is always forced to an outer node, guaranteeing a 16-digit string.
    void tryInner(int pos, uint used) {
        if (pos == 5) {
            int sumInner = 0;
            foreach (v; inner) sumInner += v;
            if ((sumInner + 55) % 5 != 0) return;
            immutable int S = (sumInner + 55) / 5;

            // outer[i] = S − inner[i] − inner[(i+1)%5]; must cover {1..10} \ inner exactly
            int[5] outer;
            uint usedAll = used;
            foreach (i; 0 .. 5) {
                immutable int o = S - inner[i] - inner[(i + 1) % 5];
                if (o < 1 || o > 10 || (usedAll >> (o - 1)) & 1) return;
                outer[i] = o;
                usedAll |= 1u << (o - 1);
            }

            // Build string starting from the group with the smallest outer node
            int start = 0;
            foreach (i; 1 .. 5)
                if (outer[i] < outer[start]) start = i;

            string s;
            foreach (i; 0 .. 5) {
                immutable int idx = (start + i) % 5;
                s ~= to!string(outer[idx]);
                s ~= to!string(inner[idx]);
                s ~= to!string(inner[(idx + 1) % 5]);
            }
            if (s.length == 16 && s > maxStr) maxStr = s;
            return;
        }
        foreach (int v; 1 .. 10) {
            if ((used >> (v - 1)) & 1) continue;
            inner[pos] = v;
            tryInner(pos + 1, used | (1u << (v - 1)));
        }
    }

    tryInner(0, 0);
    return maxStr;
}

void main() { runSolution!(solve)(68); }
