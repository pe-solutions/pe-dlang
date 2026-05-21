// Passcode Derivation
// https://projecteuler.net/problem=79

import std.string : splitLines;
import euler.common : runSolution;

enum string data = import("data/keylog.txt");

auto solve() {
    bool[10][10] before;  // before[a][b]: a must appear before b
    bool[10] used;

    foreach (line; data.splitLines) {
        if (line.length < 3) continue;
        int[3] d = [line[0] - '0', line[1] - '0', line[2] - '0'];
        used[d[0]] = used[d[1]] = used[d[2]] = true;
        before[d[0]][d[1]] = before[d[0]][d[2]] = before[d[1]][d[2]] = true;
    }

    // Kahn's algorithm: repeatedly place the smallest digit with no unplaced predecessor.
    bool[10] placed;
    long ans = 0;
    foreach (_; 0 .. 10) {
        foreach (d; 0 .. 10) {
            if (!used[d] || placed[d]) continue;
            bool ready = true;
            foreach (p; 0 .. 10)
                if (used[p] && !placed[p] && before[p][d]) { ready = false; break; }
            if (ready) { placed[d] = true; ans = ans * 10 + d; break; }
        }
    }
    return ans;
}

void main() { runSolution!(solve)(79); }
