// Perfect Square Collection
// https://projecteuler.net/problem=142

import euler.common : runSolution;

// x+y=p², x-y=q², x+z=r², x-z=s², y+z=t², y-z=u², all perfect squares.
// x=(p²+q²)/2, y=(t²+u²)/2, z=(t²-u²)/2; parity requires t≡u (mod 2).
// Setting p²−q² = t²+u² (= 2y) reduces x+z and x−z to r²=q²+t², s²=q²+u²,
// with p²=r²+u² (= q²+t²+u²). x+y+z = (p²+q²)/2 + t².
// Enumerate q,t,u with t>u>0 and the three square conditions; minimise sum.
auto solve() {
    enum int LIMIT = 1100;
    enum long MAX2  = 2L * LIMIT * LIMIT;   // covers r²=q²+t² and p²=r²+u²

    static bool[MAX2 + 1] isSquare;
    for (long i = 1; i * i <= MAX2; ++i)
        isSquare[i * i] = true;

    long best = long.max;

    for (int q = 1; q < LIMIT; ++q) {
        immutable long q2 = cast(long) q * q;
        for (int t = 1; q2 + cast(long) t * t <= MAX2; ++t) {
            immutable long r2 = q2 + cast(long) t * t;
            if (!isSquare[r2]) continue;
            for (int u = (t & 1) ? 1 : 2; u < t; u += 2) {
                immutable long s2 = q2 + cast(long) u * u;
                if (!isSquare[s2]) continue;
                immutable long p2 = r2 + cast(long) u * u;
                if (p2 > MAX2 || !isSquare[p2]) continue;
                immutable long sum = (p2 + q2) / 2 + cast(long) t * t;
                if (sum < best) best = sum;
            }
        }
    }
    return best;
}

void main() { runSolution!(solve)(142); }
