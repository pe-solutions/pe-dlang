// Cube Digit Pairs
// https://projecteuler.net/problem=90

import euler.common : runSolution;

auto solve() {
    import core.bitop : popcnt;
    // Digit pairs needed to display squares 01,04,09,16,25,36,49,64,81.
    // With 6≡9, pairs (4,9) and (6,4) reduce to the same constraint — keep both for clarity.
    static immutable ubyte[2][9] required = [
        [0,1],[0,4],[0,9],[1,6],[2,5],[3,6],[4,9],[6,4],[8,1]
    ];

    // Build all C(10,6)=210 face sets as bitmasks, expanding 6≡9 rule.
    uint[210] faces;
    int nf = 0;
    foreach (mask; 0u .. 1024u) {
        if (popcnt(mask) != 6) continue;
        uint m = mask;
        if (m & (1u << 6)) m |= (1u << 9);
        if (m & (1u << 9)) m |= (1u << 6);
        faces[nf++] = m;
    }

    int count = 0;
    foreach (i; 0 .. nf)
        foreach (j; i .. nf) {
            bool ok = true;
            foreach (p; required) {
                immutable uint a = 1u << p[0], b = 1u << p[1];
                if (!((faces[i] & a) && (faces[j] & b)) &&
                    !((faces[i] & b) && (faces[j] & a)))
                { ok = false; break; }
            }
            if (ok) ++count;
        }
    return count;
}

void main() { runSolution!(solve)(90); }
