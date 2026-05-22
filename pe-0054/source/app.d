// Poker Hands
// https://projecteuler.net/problem=54

import euler.common : runSolution;

private int cardVal(char c) pure nothrow @nogc
{
    if (c >= '2' && c <= '9') return c - '0';
    if (c == 'T') return 10;
    if (c == 'J') return 11;
    if (c == 'Q') return 12;
    if (c == 'K') return 13;
    return 14; // 'A'
}

// Packed int: rank in bits 23-20 (0=high-card…8=straight-flush), tiebreaker nibbles in bits 19-0.
private int evalHand(int[5] v, char[5] s) pure nothrow @nogc
{
    int[15] cnt;
    foreach (x; v) ++cnt[x];

    // Sort v descending by (cnt[v] desc, v desc) — insertion sort on 5 elements.
    foreach (i; 1 .. 5)
    {
        immutable int key = v[i];
        int j = i - 1;
        while (j >= 0 &&
               (cnt[v[j]] < cnt[key] || (cnt[v[j]] == cnt[key] && v[j] < key)))
        { v[j + 1] = v[j]; --j; }
        v[j + 1] = key;
    }

    immutable int  f0      = cnt[v[0]];
    immutable bool isFlush =
        s[0] == s[1] && s[1] == s[2] && s[2] == s[3] && s[3] == s[4];

    // Straight: all values distinct (f0 == 1) and either span-4 or A-2-3-4-5 wheel.
    bool isStraight = false;
    int  high       = v[0];
    if (f0 == 1)
    {
        if      (v[0] - v[4] == 4) isStraight = true;
        else if (v[0] == 14 && v[1] == 5 && v[4] == 2)
            { isStraight = true; high = 5; }  // wheel: Ace plays low
    }

    if (isFlush && isStraight)      return (8 << 20) | (high << 16);
    if (f0 == 4)                    return (7 << 20) | (v[0] << 16) | (v[4] << 12);
    if (f0 == 3 && cnt[v[3]] == 2) return (6 << 20) | (v[0] << 16) | (v[3] << 12);
    if (isFlush)                    return (5 << 20) | (v[0] << 16) | (v[1] << 12) | (v[2] << 8) | (v[3] << 4) | v[4];
    if (isStraight)                 return (4 << 20) | (high << 16);
    if (f0 == 3)                    return (3 << 20) | (v[0] << 16) | (v[3] << 12) | (v[4] << 8);
    if (f0 == 2 && cnt[v[2]] == 2) return (2 << 20) | (v[0] << 16) | (v[2] << 12) | (v[4] << 8);
    if (f0 == 2)                    return (1 << 20) | (v[0] << 16) | (v[2] << 12) | (v[3] << 8) | (v[4] << 4);
    return                                 (v[0] << 16) | (v[1] << 12) | (v[2] << 8) | (v[3] << 4) | v[4];
}

auto solve()
{
    import std.string : splitLines;
    enum string data = import("data/poker.txt");
    int count = 0;

    foreach (line; data.splitLines())
    {
        int[5] v1, v2;
        char[5] s1, s2;
        foreach (i; 0 .. 5)
        {
            v1[i] = cardVal(line[3 * i]);
            s1[i] = line[3 * i + 1];
            v2[i] = cardVal(line[15 + 3 * i]);
            s2[i] = line[15 + 3 * i + 1];
        }
        if (evalHand(v1, s1) > evalHand(v2, s2)) ++count;
    }

    return count;
}

void main() { runSolution!(solve)(54); }
