// Very Odd Numbers
// https://projecteuler.net/problem=974

import std.algorithm.mutation : swap;
import euler.common : runSolution;

enum DC  = 5;
enum DG  = [1,3,5,7,9];
enum MOD = 105;
enum MSK = 32;
enum ST  = MOD * MSK;

void buildTables(ref int[DC * MOD] nxR, ref int[DC] fl)
{
    foreach (r; 0 .. MOD)
        foreach (d; 0 .. DC)
            nxR[r * DC + d] = (r * 10 + DG[d]) % MOD;
    foreach (d; 0 .. DC)
        fl[d] = 1 << d;
}

void findLen(ref const int[DC * MOD] nxR, ref const int[DC] fl,
             ulong target, out int bestLen, out ulong prefix)
{
    auto cur = new ulong[ST];
    auto nxt = new ulong[ST];
    cur[0] = 1;
    prefix = 0;
    for (int L = 1; ; L++)
    {
        nxt[] = 0;
        foreach (r; 0 .. MOD)
        {
            int rb = r * MSK;
            int rd = r * DC;
            foreach (m; 0 .. MSK)
            {
                ulong w = cur[rb + m];
                if (!w) continue;
                nxt[nxR[rd + 0] * MSK + (m ^ fl[0])] += w;
                nxt[nxR[rd + 1] * MSK + (m ^ fl[1])] += w;
                nxt[nxR[rd + 2] * MSK + (m ^ fl[2])] += w;
                nxt[nxR[rd + 3] * MSK + (m ^ fl[3])] += w;
                nxt[nxR[rd + 4] * MSK + (m ^ fl[4])] += w;
            }
        }
        swap(cur, nxt);
        if (L & 1)
        {
            ulong c = cur[31];
            if (prefix + c >= target)
            {
                bestLen = L;
                return;
            }
            prefix += c;
        }
    }
}

ulong[] buildComp(ref const int[DC * MOD] nxR, ref const int[DC] fl, int len)
{
    auto comp = new ulong[(len + 1) * ST];
    comp[31] = 1;
    foreach (s; 1 .. len + 1)
    {
        int off  = s * ST;
        int poff = (s - 1) * ST;
        foreach (r; 0 .. MOD)
        {
            int rb = r * MSK;
            int rd = r * DC;
            int c0 = poff + nxR[rd + 0] * MSK;
            int c1 = poff + nxR[rd + 1] * MSK;
            int c2 = poff + nxR[rd + 2] * MSK;
            int c3 = poff + nxR[rd + 3] * MSK;
            int c4 = poff + nxR[rd + 4] * MSK;
            foreach (m; 0 .. MSK)
            {
                comp[off + rb + m] =
                      comp[c0 + (m ^ fl[0])]
                    + comp[c1 + (m ^ fl[1])]
                    + comp[c2 + (m ^ fl[2])]
                    + comp[c3 + (m ^ fl[3])]
                    + comp[c4 + (m ^ fl[4])];
            }
        }
    }
    return comp;
}

string buildAnswer(ref const int[DC * MOD] nxR, ref const int[DC] fl,
                   ulong k, int len, const ulong[] comp)
{
    char[] res;
    res.length = len;
    int r = 0, m = 0;
    foreach (i; 0 .. len)
    {
        int rem = len - i - 1;
        int off = rem * ST;
        int rd  = r * DC;
        foreach (d; 0 .. DC)
        {
            int nr  = nxR[rd + d];
            int nm  = m ^ fl[d];
            ulong cnt = comp[off + nr * MSK + nm];
            if (k > cnt)
                k -= cnt;
            else
            {
                res[i] = cast(char)('0' + DG[d]);
                r = nr;
                m = nm;
                break;
            }
        }
    }
    return cast(string) res;
}

auto solve()
{
    enum ulong TARGET = 10_000_000_000_000_000UL;
    int[DC * MOD] nxR;
    int[DC] fl;
    buildTables(nxR, fl);
    int  bestLen;
    ulong prefix;
    findLen(nxR, fl, TARGET, bestLen, prefix);
    auto comp = buildComp(nxR, fl, bestLen);
    return buildAnswer(nxR, fl, TARGET - prefix, bestLen, comp);
}

void main() { runSolution!(solve)(974); }
