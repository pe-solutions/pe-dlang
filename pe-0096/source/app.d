// Su Doku
// https://projecteuler.net/problem=96

import std.string   : splitLines, strip, startsWith;
import core.bitop   : popcnt, bsf;
import euler.common : runSolution;

enum int FULL = 0x3FE;  // bits 1..9 set

struct Board {
    int[9][9] cell;
    int[9] rowUsed, colUsed, boxUsed;
}

int boxOf(int r, int c) pure { return (r / 3) * 3 + c / 3; }

bool backtrack(ref Board b) {
    // MRV: pick the empty cell with the fewest available digits.
    int br = -1, bc = -1, bavail = FULL;
    foreach (r; 0 .. 9) foreach (c; 0 .. 9) {
        if (b.cell[r][c] != 0) continue;
        immutable int avail = FULL & ~(b.rowUsed[r] | b.colUsed[c] | b.boxUsed[boxOf(r, c)]);
        if (avail == 0) return false;
        if (popcnt(avail) < popcnt(bavail)) { bavail = avail; br = r; bc = c; }
    }
    if (br == -1) return true;  // all cells filled

    immutable int bx = boxOf(br, bc);
    for (int av = bavail; av; av &= av - 1) {
        immutable int bit = av & -av;
        b.cell[br][bc] = bsf(bit);
        b.rowUsed[br] |= bit;  b.colUsed[bc] |= bit;  b.boxUsed[bx] |= bit;
        if (backtrack(b)) return true;
        b.cell[br][bc] = 0;
        b.rowUsed[br] ^= bit;  b.colUsed[bc] ^= bit;  b.boxUsed[bx] ^= bit;
    }
    return false;
}

auto solve() {
    enum string data = import("data/sudoku.txt");
    int sum = 0;
    Board b;
    int row = 0;

    foreach (line; data.splitLines) {
        immutable string s = line.strip;
        if (s.startsWith("Grid")) { b = Board.init; row = 0; continue; }
        if (s.length != 9) continue;
        foreach (c; 0 .. 9) {
            immutable int d = s[c] - '0';
            b.cell[row][c] = d;
            if (d) {
                immutable int bit = 1 << d;
                b.rowUsed[row]        |= bit;
                b.colUsed[c]          |= bit;
                b.boxUsed[boxOf(row, c)] |= bit;
            }
        }
        if (++row == 9) {
            backtrack(b);
            sum += b.cell[0][0] * 100 + b.cell[0][1] * 10 + b.cell[0][2];
        }
    }

    return sum;
}

void main() { runSolution!(solve)(96); }
