// Arithmetic Expressions
// https://projecteuler.net/problem=93

import std.algorithm : nextPermutation;
import std.conv      : to;
import euler.common  : runSolution;

// Exact rational — avoids fp errors from intermediate fractions like (1/3)*3.
struct Rat { long n, d; bool ok = true; }

Rat applyOp(Rat a, int op, Rat b) {
    if (!a.ok || !b.ok) return Rat(0, 0, false);
    final switch (op) {
        case 0: return Rat(a.n*b.d + b.n*a.d, a.d*b.d);
        case 1: return Rat(a.n*b.d - b.n*a.d, a.d*b.d);
        case 2: return Rat(a.n*b.n, a.d*b.d);
        case 3:
            if (b.n == 0) return Rat(0, 0, false);
            long nn = a.n*b.d, nd = a.d*b.n;
            return nd < 0 ? Rat(-nn, -nd) : Rat(nn, nd);
    }
}

bool isPosInt(Rat r) {
    return r.ok && r.n > 0 && r.d > 0 && r.n % r.d == 0;
}

// Evaluate all 5 parenthesisations × 64 operator combos for one digit permutation.
void collect(long[4] p, bool[] reach) {
    Rat[4] v = [Rat(p[0],1), Rat(p[1],1), Rat(p[2],1), Rat(p[3],1)];
    foreach (ops; 0 .. 64) {
        int o0 = ops & 3, o1 = (ops >> 2) & 3, o2 = ops >> 4;
        Rat[5] t = [
            applyOp(applyOp(applyOp(v[0],o0,v[1]),o1,v[2]),o2,v[3]),  // ((a○b)○c)○d
            applyOp(applyOp(v[0],o0,applyOp(v[1],o1,v[2])),o2,v[3]),  // (a○(b○c))○d
            applyOp(applyOp(v[0],o0,v[1]),o1,applyOp(v[2],o2,v[3])),  // (a○b)○(c○d)
            applyOp(v[0],o0,applyOp(applyOp(v[1],o1,v[2]),o2,v[3])),  // a○((b○c)○d)
            applyOp(v[0],o0,applyOp(v[1],o1,applyOp(v[2],o2,v[3]))),  // a○(b○(c○d))
        ];
        foreach (r; t)
            if (isPosInt(r)) { auto val = r.n / r.d; if (val < reach.length) reach[val] = true; }
    }
}

auto solve() {
    int bestN, bestA, bestB, bestC, bestD;
    auto reach = new bool[4096];

    foreach (a; 0 .. 7) foreach (b; a+1 .. 8) foreach (c; b+1 .. 9) foreach (d; c+1 .. 10) {
        reach[] = false;
        long[4] perm = [a, b, c, d];
        do { collect(perm, reach); } while (nextPermutation(perm[]));

        int n = 0;
        while (n + 1 < 4096 && reach[n + 1]) n++;

        if (n > bestN) { bestN = n; bestA = a; bestB = b; bestC = c; bestD = d; }
    }

    return to!string(bestA) ~ to!string(bestB) ~ to!string(bestC) ~ to!string(bestD);
}

void main() { runSolution!(solve)(93); }
