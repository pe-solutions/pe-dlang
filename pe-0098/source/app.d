// Anagramic Squares
// https://projecteuler.net/problem=98

import std.algorithm : sort, map, max, filter;
import std.array    : array;
import std.conv     : to;
import std.math     : sqrt;
import std.string   : split, strip;
import euler.common : runSolution;

bool isSquare(long n) {
    if (n <= 0) return false;
    long s = cast(long)sqrt(cast(double)n);
    return s * s == n || (s + 1) * (s + 1) == n;
}

// Returns (value, string-form) pairs for all N-digit squares, largest first.
struct Sq { long val; string str; }

Sq[] nDigitSquares(int n) {
    long lo = 1;
    foreach (_; 1 .. n) lo *= 10;
    long hi = lo * 10 - 1;
    // Correct fp rounding at boundary: find exact iMin/iMax.
    long iMin = cast(long)sqrt(cast(double)lo);
    while (iMin * iMin < lo) iMin++;
    long iMax = cast(long)sqrt(cast(double)hi);
    while ((iMax + 1) * (iMax + 1) <= hi) iMax++;
    Sq[] result;
    for (long i = iMax; i >= iMin; i--)
        result ~= Sq(i * i, (i * i).to!string);
    return result;
}

// Fills m[0..26] with the letter→digit mapping induced by matching word w to ns.
// Returns false on any inconsistency (same letter→two digits, or two letters→same digit).
bool buildMap(string w, string ns, ref int[26] m, ref bool[10] used) {
    m[]   = -1;
    used[] = false;
    foreach (i, c; w) {
        int li = c - 'A';
        int d  = ns[i] - '0';
        if (m[li] < 0) {
            if (used[d]) return false;
            m[li] = d;
            used[d] = true;
        } else if (m[li] != d) {
            return false;
        }
    }
    return true;
}

long applyMap(string w, ref int[26] m) {
    long r = 0;
    foreach (c; w)
        r = r * 10 + m[c - 'A'];
    return r;
}

auto solve() {
    string[] words = import("data/words.txt").strip.split(",").map!(w => w[1 .. $ - 1]).array;

    // Group by sorted-letter key to find anagram families.
    string[][string] groups;
    foreach (w; words) {
        ubyte[] key = cast(ubyte[]) w.dup;
        sort(key);
        groups[(cast(char[]) key).idup] ~= w;
    }

    // Only multi-word groups, sorted by word length descending so we can exit early.
    auto anagramGroups = groups.byValue
        .filter!(g => g.length >= 2)
        .array
        .sort!((a, b) => a[0].length > b[0].length)
        .release;

    long best = 0;
    int[26] m;
    bool[10] used;

    foreach (g; anagramGroups) {
        int n  = cast(int)g[0].length;
        long lo = 1; foreach (_; 1 .. n) lo *= 10;
        long hi = lo * 10 - 1;

        // No n-digit square can beat the current best; all subsequent groups are shorter.
        if (hi <= best) break;

        auto sqs = nDigitSquares(n);   // pre-sorted largest-first, string forms cached

        for (size_t i = 0; i < g.length; i++) {
            for (size_t j = i + 1; j < g.length; j++) {
                string w1 = g[i], w2 = g[j];
                foreach (ref sq; sqs) {
                    if (!buildMap(w1, sq.str, m, used)) continue;
                    long n2 = applyMap(w2, m);
                    if (n2 < lo || n2 > hi) continue;   // rejects leading zero without allocation
                    if (!isSquare(n2)) continue;
                    best = max(best, sq.val, n2);
                }
            }
        }
    }

    return best;
}

void main() { runSolution!(solve)(98); }
