// Path Sum: Four Ways
// https://projecteuler.net/problem=83

import euler.common : runSolution;

private struct Entry {
    long cost;
    int r, c;
}

auto solve() {
    import std.container : Array, BinaryHeap;
    enum int N = 80;
    static immutable int[N][N] grid = () {
        import std.array : split;
        import std.conv : to;
        import std.string : splitLines;
        int[N][N] g;
        foreach (r, line; import("data/matrix.txt").splitLines)
            foreach (c, tok; line.split(","))
                g[r][c] = tok.to!int;
        return g;
    }();

    long[N][N] dist;
    foreach (ref row; dist) row[] = long.max / 2;
    dist[0][0] = grid[0][0];

    auto pq = BinaryHeap!(Array!Entry, "a.cost > b.cost")(Array!Entry.init);
    pq.insert(Entry(grid[0][0], 0, 0));

    immutable int[4] dr = [-1, 1, 0, 0];
    immutable int[4] dc = [0, 0, -1, 1];

    while (!pq.empty) {
        immutable e = pq.front;
        pq.removeFront();
        if (e.cost > dist[e.r][e.c]) continue;
        foreach (d; 0 .. 4) {
            immutable int nr = e.r + dr[d];
            immutable int nc = e.c + dc[d];
            if (nr < 0 || nr >= N || nc < 0 || nc >= N) continue;
            immutable long newCost = e.cost + grid[nr][nc];
            if (newCost < dist[nr][nc]) {
                dist[nr][nc] = newCost;
                pq.insert(Entry(newCost, nr, nc));
            }
        }
    }
    return dist[N-1][N-1];
}

void main() { runSolution!(solve)(83); }
