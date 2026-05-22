// Monopoly Odds
// https://projecteuler.net/problem=84

import euler.common : runSolution;

auto solve() {
    import std.algorithm : sort;
    import std.array : array;
    import std.format : format;
    import std.range : iota;
    enum int N = 40;
    enum int STATES = N * 3;  // position × consecutive doubles (0,1,2)

    double[STATES] v;
    v[] = 1.0 / STATES;

    // Distribute probability p of landing on sq (with doubles state dbl) into nxt.
    // Handles G2J, CC, CH (including recursive CH3→CC3), and normal squares.
    void land(ref double[STATES] nxt, int sq, int dbl, double p) {
        if (sq == 30) { nxt[10 * 3 + 0] += p; return; }  // G2J → Jail
        if (sq == 2 || sq == 17 || sq == 33) {            // Community Chest
            nxt[ 0 * 3 + dbl] += p / 16;          // GO
            nxt[10 * 3 +   0] += p / 16;          // Jail
            nxt[sq * 3 + dbl] += p * 14.0 / 16;  // stay
            return;
        }
        if (sq == 7 || sq == 22 || sq == 36) {            // Chance
            immutable int nxtR  = sq ==  7 ? 15 : sq == 22 ? 25 : 5;
            immutable int nxtU  = sq ==  7 ? 12 : sq == 22 ? 28 : 12;
            immutable int back3 = (sq + N - 3) % N;
            nxt[ 0 * 3 + dbl]    += p / 16;         // GO
            nxt[10 * 3 +   0]    += p / 16;         // Jail
            nxt[11 * 3 + dbl]    += p / 16;         // C1
            nxt[24 * 3 + dbl]    += p / 16;         // E3
            nxt[39 * 3 + dbl]    += p / 16;         // H2
            nxt[ 5 * 3 + dbl]    += p / 16;         // R1
            nxt[nxtR * 3 + dbl]  += 2.0 * p / 16;  // next R (2 cards)
            nxt[nxtU * 3 + dbl]  += p / 16;         // next U
            land(nxt, back3, dbl,  p / 16);         // back 3 (CH3→CC3 handled recursively)
            nxt[sq * 3 + dbl]    += 6.0 * p / 16;  // stay (6 cards)
            return;
        }
        nxt[sq * 3 + dbl] += p;
    }

    foreach (_; 0 .. 500) {
        double[STATES] nxt;
        nxt[] = 0.0;
        foreach (pos; 0 .. N) {
            foreach (dbl; 0 .. 3) {
                immutable double p = v[pos * 3 + dbl];
                if (p == 0.0) continue;
                foreach (d1; 1 .. 5) {
                    foreach (d2; 1 .. 5) {
                        immutable bool isDouble = (d1 == d2);
                        immutable double q = p / 16.0;
                        if (isDouble && dbl == 2) {
                            nxt[10 * 3 + 0] += q;  // 3rd double → Jail
                        } else {
                            immutable int newPos = (pos + d1 + d2) % N;
                            immutable int newDbl = isDouble ? dbl + 1 : 0;
                            land(nxt, newPos, newDbl, q);
                        }
                    }
                }
            }
        }
        v = nxt;
    }

    double[N] sq;
    sq[] = 0.0;
    foreach (s; 0 .. STATES) sq[s / 3] += v[s];

    auto idx = iota(N).array;
    sort!((a, b) => sq[a] > sq[b])(idx);

    return format("%02d%02d%02d", idx[0], idx[1], idx[2]);
}

void main() { runSolution!(solve)(84); }
