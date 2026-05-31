// Twisted Somos-4 Sequence
// https://projecteuler.net/problem=999

import std.meta   : AliasSeq;
import std.string : indexOf;
import std.traits : isIntegral;
import euler.common : runSolution;

private enum ulong MODULUS = 1234567891UL;

// ---------------------------------------------------------------------------
// Generic modular field — shared across all four approaches.
// ---------------------------------------------------------------------------
private struct Mod(ulong P)
{
    ulong v;

    this(ulong x) pure nothrow @nogc { v = x % P; }

    // Operands stay < P < 2^31, so products are < 2^62 and never overflow ulong.
    Mod opBinary(string op)(Mod rhs) const pure nothrow @nogc
    {
        static if (op == "+") return Mod((v + rhs.v) % P);
        else static if (op == "-") return Mod((v + P - rhs.v) % P);
        else static if (op == "*") return Mod((v * rhs.v) % P);
        else static assert(0, "unsupported op " ~ op);
    }
    Mod opBinary(string op : "*", T)(T k) const pure nothrow @nogc
        if (isIntegral!T)
    {
        return this * Mod(cast(ulong) k);
    }

    Mod opUnary(string op : "-")() const pure nothrow @nogc { return Mod((P - v) % P); }

    Mod pow(ulong e) const pure nothrow @nogc
    {
        Mod r = Mod(1), b = this;
        for (; e; e >>= 1) { if (e & 1) r = r * b; b = b * b; }
        return r;
    }
    Mod inv()  const pure nothrow @nogc { return pow(P - 2); }   // Fermat (P prime)
    Mod sq()   const pure nothrow @nogc { return this * this; }
    Mod cube() const pure nothrow @nogc { return this * this * this; }

    bool opEquals(const Mod rhs) const pure nothrow @nogc { return v == rhs.v; }
    bool opEquals(ulong x)      const pure nothrow @nogc { return v == x % P; }
}

// Approach 1 — memoized halving recurrence, O(log² n) distinct indices
private struct Somos(ulong P)
{
    alias F = Mod!P;
    enum int BASE = 50;

    F[BASE] base;
    F[long]  memo;

    void seed()
    {
        base[0] = F(0);
        base[1] = base[2] = base[3] = F(1);
        base[4] = F(2);
        foreach (n; 3 .. BASE - 2)
        {
            immutable u = (n & 1) ? F(2) : F(1);          // u=2 (odd n), u=1 (even n)
            base[n + 2] = (base[n].sq - u * base[n + 1] * base[n - 1]) * base[n - 2].inv;
        }
    }

    F a(long m)
    {
        if (m < BASE) return base[m];
        if (m in memo) return memo[m];

        F result;
        if (m & 1)
        {
            immutable long n = (m - 1) / 2;
            immutable F neg = (n & 1) ? F(1) : -F(1);     // (-1)^{n+1}
            immutable F c1  = (n & 1) ? F(1) : F(2);      // 1 + [n even]
            immutable F c2  = (n & 1) ? F(2) : F(1);      // 1 + [n odd]
            immutable t = c1 * a(n + 2) * a(n).cube - c2 * a(n + 1).cube * a(n - 1);
            result = neg * t;
        }
        else
        {
            immutable long n = m / 2;
            immutable F neg = (n & 1) ? -F(1) : F(1);     // (-1)^n
            immutable t = a(n + 2) * a(n) * a(n - 1).sq - a(n) * a(n - 2) * a(n + 1).sq;
            result = neg * t;
        }

        memo[m] = result;
        return result;
    }
}

private ulong solveMemo(ulong P)(long n)
{
    auto s = Somos!P();
    s.seed();
    return s.a(n).v;
}

// Approach 2 — 7-window double-and-add ladder, O(log n) window steps
private alias W7(F) = F[7];

private int uCoeff(long k) pure nothrow @nogc { return (k & 1) ? 2 : 1; }

private W7!F doubleStep(F)(const W7!F W, long k) pure nothrow @nogc
{
    immutable bool kOdd = (k & 1) != 0;
    immutable F ek = F(uCoeff(k)), ok = F(uCoeff(k + 1));

    F sgn(F x) { return kOdd ? -x : x; }
    F opp(F x) { return kOdd ?  x : -x; }

    W7!F R;
    R[0] = sgn(ek * W[2].cube * W[0] - ok * W[3]      * W[1].cube);
    R[1] = opp(W[2] * (W[4] * W[1].sq - W[0] * W[3].sq));
    R[2] = opp(ok * W[3].cube * W[1] - ek * W[4]      * W[2].cube);
    R[3] = sgn(W[3] * (W[5] * W[2].sq - W[1] * W[4].sq));
    R[4] = sgn(ek * W[4].cube * W[2] - ok * W[5]      * W[3].cube);
    R[5] = opp(W[4] * (W[6] * W[3].sq - W[2] * W[5].sq));
    R[6] = opp(ok * W[5].cube * W[3] - ek * W[6]      * W[4].cube);
    return R;
}

private W7!F increment7(F)(const W7!F W) pure nothrow @nogc
{
    immutable next = (W[5] * W[5] - W[6] * W[4]) * W[3].inv;
    W7!F R = void;
    R[0] = W[1]; R[1] = W[2]; R[2] = W[3]; R[3] = W[4];
    R[4] = W[5]; R[5] = W[6]; R[6] = next;
    return R;
}

private ulong solveLadder7(ulong P)(long n) pure nothrow
{
    alias F = Mod!P;
    if (n < 5) { immutable ulong[5] small = [0, 1, 1, 1, 2]; return small[n] % P; }

    F[7] W = [ F(P - 1), F(1), F(0), F(1), F(1), F(1), F(2) ];
    long k = 1;

    int top = 63;
    while (top >= 0 && !((n >> top) & 1)) --top;
    for (int bit = top - 1; bit >= 0; --bit)
    {
        W = doubleStep!F(W, k); k *= 2;
        if ((n >> bit) & 1) { W = increment7!F(W); ++k; }
    }
    assert(k == n);
    return W[3].v;
}

// Approach 3 — elliptic-divisibility-sequence formulation, O(log n) EDS ladder
private template CurveEDS(F)
{
    // Weierstrass invariants for a2=-1, a6=1 (a1=a3=a4=0): b4=0, b6=4, b8=-4.
    enum F b4 = F(0), b6 = F(4), b8 = -F(4);

    enum F psi1 = F(1);
    enum F psi2 = -F(2);                         // 2*y, y = -1
    enum F psi3 = b8;
    enum F psi4 = psi2 * (b4 * b8 - b6.sq);
    enum F invPsi2 = psi2.inv;
}

private struct WindowEDS(F)
{
    alias C = CurveEDS!F;
    long center;
    F[8] a;                                      // a[i] == psi_{center-3+i}(P)

    ref inout(F) opIndex(long idx) inout pure nothrow @nogc
    {
        return a[idx - (center - 3)];
    }

    // psi_{2m} = psi_m (psi_{m+2} psi_{m-1}^2 - psi_{m-2} psi_{m+1}^2) / psi_2
    F even(long m) const pure nothrow @nogc
    {
        immutable d = this[m + 2] * this[m - 1].sq - this[m - 2] * this[m + 1].sq;
        return this[m] * d * C.invPsi2;
    }
    // psi_{2m+1} = psi_{m+2} psi_m^3 - psi_{m-1} psi_{m+1}^3
    F oddUp(long m) const pure nothrow @nogc
    {
        return this[m + 2] * this[m].cube - this[m - 1] * this[m + 1].cube;
    }
    // psi_{2m-1} = psi_{m+1} psi_{m-1}^3 - psi_{m-2} psi_m^3
    F oddDown(long m) const pure nothrow @nogc
    {
        return this[m + 1] * this[m - 1].cube - this[m - 2] * this[m].cube;
    }

    WindowEDS step(int off)() const pure nothrow @nogc
    {
        immutable long k = center;
        WindowEDS r;
        r.center = 2 * k + off;

        static if (off == 0)
            alias gens = AliasSeq!("oddUp,-2", "even,-1", "oddDown,0", "even,0",
                                   "oddUp,0",  "even,1",  "oddUp,1",   "even,2");
        else
            alias gens = AliasSeq!("even,-1", "oddDown,0", "even,0", "oddUp,0",
                                   "even,1",  "oddUp,1",   "even,2", "oddUp,2");

        static foreach (i, spec; gens)
        {{
            enum comma  = spec.indexOf(',');
            enum method = spec[0 .. comma];
            enum delta  = mixin(spec[comma + 1 .. $]);
            r.a[i] = mixin("this." ~ method ~ "(k + delta)");
        }}
        return r;
    }
}

private WindowEDS!(Mod!P) seedWindowEDS(ulong P)(long center) pure nothrow
{
    alias F = Mod!P;
    alias C = CurveEDS!F;
    enum int CAP = 50;
    F[CAP + 1] p;
    p[1] = C.psi1; p[2] = C.psi2; p[3] = C.psi3; p[4] = C.psi4;
    foreach (n; 2 .. (CAP - 1) / 2 + 1)
    {
        p[2*n+1] = p[n+2] * p[n].cube - p[n-1] * p[n+1].cube;
        if (2*n > 4)
            p[2*n] = p[n] * (p[n+2] * p[n-1].sq - p[n-2] * p[n+1].sq) * C.invPsi2;
    }
    typeof(return) w;
    w.center = center;
    static foreach (i; 0 .. 8) w.a[i] = p[center - 3 + i];
    return w;
}

private Mod!P psiEDS(ulong P)(long target) pure nothrow
{
    int top = 63;
    while (top >= 0 && !((target >> top) & 1)) --top;

    long k = 0; int bit = top;
    while (k < 5 && bit >= 0) { k = (k << 1) | ((target >> bit) & 1); --bit; }

    auto w = seedWindowEDS!P(k);
    for (; bit >= 0; --bit)
        w = ((target >> bit) & 1) ? w.step!1 : w.step!0;

    assert(w.center == target);
    return w[target];
}

private Mod!P cFactor(ulong P)(long N) pure nothrow
{
    enum ulong M = P - 1;
    immutable ulong k  = N / 2;
    immutable ulong km = k % M;
    immutable base = Mod!P(P - (((N + 1) % 2) + 1));
    immutable ulong e2 = (km * ((k + 1) % M)) % M;   // k*(k+1) overflows: reduce first
    return base.pow(km) * Mod!P(2).pow(e2).inv;
}

private ulong solveEDS(ulong P)(long N) pure nothrow
{
    return (cFactor!P(N) * psiEDS!P(N)).v;
}

// Approach 4 — parity-twisted 8-window double-and-add (preferred)
private struct Window(F)
{
    long center;
    F[8] a;                                    // a[i] == term at (center - 3 + i)

    ref inout(F) opIndex(long idx) inout pure nothrow @nogc
    {
        return a[idx - (center - 3)];
    }

    // a_{2n} = (-1)^n * a_n * (a_{n+2} a_{n-1}^2 - a_{n-2} a_{n+1}^2)
    F even(long n) const pure nothrow @nogc
    {
        immutable d = this[n + 2] * (this[n - 1] * this[n - 1])
                    - this[n - 2] * (this[n + 1] * this[n + 1]);
        immutable b = this[n] * d;
        return (n & 1) ? -b : b;
    }
    // a_{2n+1}: n odd -> x - 2y, n even -> y - 2x,  x = a_{n+2} a_n^3,  y = a_{n+1}^3 a_{n-1}
    F oddUp(long n) const pure nothrow @nogc
    {
        immutable x = this[n + 2] * this[n].cube;
        immutable y = this[n + 1].cube * this[n - 1];
        return (n & 1) ? x - y * 2 : y - x * 2;
    }
    // a_{2n-1}: same parity rule, x = a_{n-2} a_n^3,  y = a_{n+1} a_{n-1}^3
    F oddDown(long n) const pure nothrow @nogc
    {
        immutable x = this[n - 2] * this[n].cube;
        immutable y = this[n + 1] * this[n - 1].cube;
        return (n & 1) ? x - y * 2 : y - x * 2;
    }

    Window step(int off)() const pure nothrow @nogc
    {
        immutable long k = center;
        Window r;
        r.center = 2 * k + off;

        static if (off == 0)
            alias gens = AliasSeq!("oddUp,-2", "even,-1", "oddDown,0", "even,0",
                                   "oddUp,0",  "even,1",  "oddUp,1",   "even,2");
        else
            alias gens = AliasSeq!("even,-1", "oddDown,0", "even,0", "oddUp,0",
                                   "even,1",  "oddUp,1",   "even,2", "oddUp,2");

        static foreach (i, spec; gens)
        {{
            enum comma  = spec.indexOf(',');
            enum method = spec[0 .. comma];
            enum delta  = mixin(spec[comma + 1 .. $]);
            r.a[i] = mixin("this." ~ method ~ "(k + delta)");
        }}
        return r;
    }
}

private Window!(Mod!P) seedWindow(ulong P)(long center) pure nothrow
{
    enum int N = 48;
    Mod!P[N + 1] t;
    t[1] = t[2] = t[3] = Mod!P(1); t[4] = Mod!P(2);
    foreach (n; 3 .. N - 1)
    {
        immutable u = (n & 1) ? 2 : 1;
        t[n + 2] = (t[n] * t[n] - t[n + 1] * t[n - 1] * u) * t[n - 2].inv;
    }
    typeof(return) w;
    w.center = center;
    static foreach (i; 0 .. 8) w.a[i] = t[center - 3 + i];
    return w;
}

private ulong solveLadder(ulong P)(long target) pure nothrow
{
    int top = 63;
    while (top >= 0 && !((target >> top) & 1)) --top;

    long k = 0; int bit = top;
    while (k < 5 && bit >= 0) { k = (k << 1) | ((target >> bit) & 1); --bit; }

    auto w = seedWindow!P(k);
    for (; bit >= 0; --bit)
        w = ((target >> bit) & 1) ? w.step!1 : w.step!0;

    assert(w.center == target);
    return w[target].v;
}

auto solve()
{
    enum long target = 1_000_000_000_000_000_000L + 3;
    immutable result = solveLadder!MODULUS(target);                            // preferred
    assert(solveMemo!MODULUS(target)    == result, "solveMemo disagrees");     // stripped by -release
    assert(solveLadder7!MODULUS(target) == result, "solveLadder7 disagrees");  // stripped by -release
    assert(solveEDS!MODULUS(target)     == result, "solveEDS disagrees");      // stripped by -release
    return result;
}

void main() { runSolution!(solve)(999); }
