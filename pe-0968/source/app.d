// 5D Summation
// https://projecteuler.net/problem=968

import std.parallelism  : TaskPool, totalCPUs;
import std.range        : iota;

import core.atomic      : atomicOp;

import euler.common : runSolution;

private enum : uint {
    Mod        = 1_000_000_007,
    Vars       = 5,
    Edges      = 10,
    Bits       = 31,
    StateCount = 59_049,
    MaskCount  = 32,
    BvecCount  = 1_024,
    SeqLen     = 1_000,
    Problems   = 100,
}

// Barrett constants removed — `% Mod` with const Mod gets optimized to magic
// multiply-shift by the compiler automatically.

private enum uint[2][Edges] edgeEP = [
    [0,1],[0,2],[0,3],[0,4],[1,2],
    [1,3],[1,4],[2,3],[2,4],[3,4],
];

// --- CTFE ---

private enum uint[Edges] pow3 = () {
    uint[Edges] p; p[0] = 1;
    static foreach (i; 1 .. Edges) p[i] = p[i - 1] * 3;
    return p;
}();

private enum byte[MaskCount][Edges] pairT = () {
    byte[MaskCount][Edges] t;
    foreach (e; 0 .. Edges)
        foreach (m; 0 .. MaskCount) {
            auto uv = edgeEP[e];
            t[e][m] = cast(byte)(((m >> uv[0]) & 1) + ((m >> uv[1]) & 1));
        }
    return t;
}();

private enum uint[SeqLen] seq = () {
    uint[SeqLen] a; a[0] = 1; a[1] = 7;
    foreach (i; 2 .. SeqLen)
        a[i] = cast(uint)((7UL * a[i-1] + cast(ulong) a[i-2] * a[i-2]) % Mod);
    return a;
}();

private enum uint[MaskCount][Bits] bitFact = () {
    uint[MaskCount][Bits] bf;
    uint[Vars] bases = [2, 3, 5, 7, 11];
    uint[Bits][Vars] pw;
    foreach (i; 0 .. Vars) {
        pw[i][0] = bases[i];
        foreach (k; 1 .. Bits)
            pw[i][k] = cast(uint)(cast(ulong) pw[i][k-1] * pw[i][k-1] % Mod);
    }
    foreach (k; 0 .. Bits)
        foreach (mask; 0 .. MaskCount) {
            ulong v = 1;
            foreach (i; 0 .. Vars)
                if (mask & (1 << i))
                    v = v * pw[i][k] % Mod;
            bf[k][mask] = cast(uint) v;
        }
    return bf;
}();

// --- Runtime tables ---

private __gshared {
    byte[Edges][StateCount] carryDig;
    uint[BvecCount][MaskCount] trans0;
}

private void initTables() {
    foreach (s; 0 .. StateCount) {
        uint t = s;
        foreach (e; 0 .. Edges) {
            carryDig[s][e] = cast(byte)(t % 3);
            t /= 3;
        }
    }
    foreach (mask; 0 .. MaskCount)
        foreach (bvec; 0 .. BvecCount) {
            uint ns = 0;
            foreach (e; 0 .. Edges) {
                int t = pairT[e][mask] - ((bvec >> e) & 1);
                int nc = (t + 1) >> 1;
                ns += (nc > 0 ? nc : 0) * pow3[e];
            }
            trans0[mask][bvec] = ns;
        }
}

// --- Work buffers ---

private final class WB {
    uint[StateCount] cur = 0;
    uint[StateCount] nxt = 0;
    int[StateCount]  act;
    int[StateCount]  nact;
}

// --- Core DP ---

private uint computeP(WB w, in uint[Edges] bounds) {
    uint[Bits] bv;
    foreach (k; 0 .. Bits) {
        uint b = 0;
        static foreach (e; 0 .. Edges)
            b |= ((bounds[e] >> k) & 1) << e;
        bv[k] = b;
    }

    w.cur[0] = 1;
    w.act[0] = 0;
    int ac = 1;

    foreach (k; 0 .. Bits) {
        int nc = 0;
        immutable bvec = bv[k];
        auto fk = bitFact[k].ptr;
        auto cur = w.cur.ptr;
        auto nxt = w.nxt.ptr;
        auto act = w.act.ptr;
        auto nact = w.nact.ptr;
        auto tr0 = trans0.ptr;

        // Precompute per-edge bound bit as int for sign-friendly arithmetic
        int[Edges] bBit;
        static foreach (e; 0 .. Edges)
            bBit[e] = (bvec >> e) & 1;

        foreach (ai; 0 .. ac) {
            immutable st = act[ai];
            immutable sv = cur[st];
            cur[st] = 0;
            if (sv == 0) continue;

            if (st == 0) {
                foreach (m; 0 .. MaskCount) {
                    immutable ns = tr0[m][bvec];
                    immutable ad = cast(uint)(cast(ulong) sv * fk[m] % Mod);
                    if (ad == 0) continue;
                    if (nxt[ns] == 0)
                        nact[nc++] = cast(int) ns;
                    uint d = nxt[ns] + ad;
                    nxt[ns] = d >= Mod ? d - Mod : d;
                }
            } else {
                auto cr = carryDig[st].ptr;
                // Precompute per-edge (carry - bBit) since this is invariant across masks
                int[Edges] crMinusB;
                static foreach (e; 0 .. Edges)
                    crMinusB[e] = cr[e] - bBit[e];

                foreach (m; 0 .. MaskCount) {
                    uint ns = 0;
                    static foreach (e; 0 .. Edges) {{
                        int t = pairT[e][m] + crMinusB[e];
                        int c = (t + 1) >> 1;
                        ns += (c > 0 ? c : 0) * pow3[e];
                    }}
                    immutable ad = cast(uint)(cast(ulong) sv * fk[m] % Mod);
                    if (ad == 0) continue;
                    if (nxt[ns] == 0)
                        nact[nc++] = cast(int) ns;
                    uint d = nxt[ns] + ad;
                    nxt[ns] = d >= Mod ? d - Mod : d;
                }
            }
        }

        {
            auto t1 = w.act; w.act = w.nact; w.nact = t1;
            auto t2 = w.cur; w.cur = w.nxt;  w.nxt  = t2;
        }
        ac = nc;
    }

    immutable result = w.cur[0];
    foreach (i; 0 .. ac)
        w.cur[w.act[i]] = 0;
    return result;
}

long solve() {
    initTables();
    shared long total = 0;

    auto pool = new TaskPool(totalCPUs);
    scope(exit) pool.finish();

    foreach (n; pool.parallel(iota(Problems))) {
        static WB tl;
        if (tl is null)
            tl = new WB();

        uint[Edges] b;
        foreach (e; 0 .. Edges)
            b[e] = seq[10 * n + e];
        atomicOp!"+="(total, cast(long) computeP(tl, b));
    }

    return total % Mod;
}

void main() { runSolution!(solve)(968); }
