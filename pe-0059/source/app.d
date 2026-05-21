// XOR Decryption
// https://projecteuler.net/problem=59

import euler.common : runSolution;

// Parse comma-separated ASCII values at compile time.
static immutable ubyte[] cipher = () {
    ubyte[] c;
    ubyte val = 0; bool inNum = false;
    foreach (ch; import("data/cipher.txt")) {
        if (ch >= '0' && ch <= '9') { val = cast(ubyte)(val * 10 + ch - '0'); inNum = true; }
        else if (inNum)             { c ~= val; val = 0; inNum = false; }
    }
    if (inNum) c ~= val;
    return c;
}();

auto solve()
{
    // Frequency-analysis approach: each key byte operates independently on
    // its own sub-stream (positions 0,3,6,… / 1,4,7,… / 2,5,8,…).
    // Try all 26 candidates per position; pick the one that maximises the
    // count of common English characters in that sub-stream.
    ubyte[3] key;
    foreach (pos; 0 .. 3)
    {
        int bestScore = -1;
        foreach (int kc; 'a' .. 'z' + 1)
        {
            int score = 0; bool ok = true;
            for (size_t i = pos; i < cipher.length; i += 3)
            {
                immutable int ch = cipher[i] ^ kc;
                if (ch < 32 || ch > 126) { ok = false; break; }
                if (ch == ' ' || ch == 'e' || ch == 't' || ch == 'a' ||
                    ch == 'o' || ch == 'i' || ch == 'n' || ch == 's')
                    ++score;
            }
            if (ok && score > bestScore) { bestScore = score; key[pos] = cast(ubyte)kc; }
        }
    }
    int sum = 0;
    foreach (i, b; cipher) sum += b ^ key[i % 3];
    return sum;
}

void main() { runSolution!(solve)(59); }
