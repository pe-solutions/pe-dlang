// Cuboid Layers
// https://projecteuler.net/problem=126

import euler.common : runSolution;

auto solve() {
    // Layer formula (derived from face + edge + corner contributions):
    // C(a,b,c,n) = 2(ab+bc+ca) + 4(a+b+c)(n-1) + 4(n-1)(n-2)
    // Count how many (a≤b≤c, n≥1) triples produce each value; return first with count=1000.
    enum int LIMIT = 20_000;

    int[LIMIT] count;

    for (int a = 1; 6*a*a < LIMIT; a++) {
        for (int b = a; 2*b*(2*a + b) < LIMIT; b++) {
            for (int c = b; ; c++) {
                immutable int f = 2*(a*b + b*c + c*a);
                if (f >= LIMIT) break;
                for (int n = 1; ; n++) {
                    immutable int cn = f + 4*(a + b + c)*(n - 1) + 4*(n - 1)*(n - 2);
                    if (cn >= LIMIT) break;
                    count[cn]++;
                }
            }
        }
    }

    foreach (int c, cnt; count)
        if (cnt == 1000) return c;

    assert(false);
}

void main() { runSolution!(solve)(126); }
