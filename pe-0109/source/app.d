// Darts
// https://projecteuler.net/problem=109

import euler.common : runSolution;

auto solve() {
    // 62 non-final dart types: S1–S20 (20), S25 (1), D1–D20 (20), D25 (1), T1–T20 (20).
    // 21 finisher types (doubles only): D1–D20, D25.
    // Values may repeat across types (e.g. S2=2 and D1=2 are distinct throws).
    int[] all, dbl;
    foreach (i; 1 .. 21) {
        all ~= i;      // single i
        all ~= 2 * i;  // double i
        all ~= 3 * i;  // treble i
        dbl ~= 2 * i;  // double i (finisher)
    }
    all ~= 25;  // single bull
    all ~= 50;  // double bull
    dbl ~= 50;  // double bull (finisher)

    int count;

    // 1-dart: finisher only.
    foreach (df; dbl)
        if (df < 100) ++count;

    // 2-dart: one non-final + finisher (order is fixed by definition).
    foreach (d1; all)
        foreach (df; dbl)
            if (d1 + df < 100) ++count;

    // 3-dart: UNORDERED pair of non-finals + finisher.
    // "S1 T1 D1 is considered the same as T1 S1 D1" — iterate j ≥ i.
    foreach (i, d1; all)
        foreach (j, d2; all)
            if (j >= i)
                foreach (df; dbl)
                    if (d1 + d2 + df < 100) ++count;

    return count;
}

void main() { runSolution!(solve)(109); }
