// Efficient Exponentiation
// https://projecteuler.net/problem=122

import euler.common : runSolution;

auto solve() {
    import std.algorithm : sum;

    // best[k] = minimum number of multiplications to compute x^k.
    int[201] best;
    best[1] = 0;

    // Star-chain IDDFS for a specific target: ch[0..pos] is the current chain,
    // 'remaining' steps left.  Returns true if target is reachable.
    // Prunings:
    //   nxt > target   — chain is increasing; can never come back down.
    //   ch[pos] << remaining < target — even doubling every step falls short.
    // Star chains are optimal for all n ≤ 12509 (covers n ≤ 200).
    int[13] ch;
    ch[0] = 1;

    bool dfs(int target, int pos, int remaining) {
        if (ch[pos] == target) return true;
        if (remaining == 0) return false;
        if ((ch[pos] << remaining) < target) return false;
        foreach_reverse (int i; 0 .. pos + 1) {
            immutable nxt = ch[pos] + ch[i];
            if (nxt > target) continue;
            ch[pos + 1] = nxt;
            if (dfs(target, pos + 1, remaining - 1)) return true;
        }
        return false;
    }

    foreach (k; 2 .. 201) {
        foreach (d; 1 .. 13) {
            if (dfs(k, 0, d)) { best[k] = d; break; }
        }
    }

    return best[1 .. 201].sum;
}

void main() { runSolution!(solve)(122); }
