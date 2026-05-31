/// Operations Research and Optimization solvers.
module euler.optim;

import std.traits : isNumeric;

/// =======================
/// Assignment Problem — Bitmask DP (fast for small N)
/// =======================
/// Solves maximum-weight perfect matching via bitmask dynamic programming.
/// Complexity: O(2^N · N²), suitable for N ≤ 20.
private struct BitmaskDP(T, size_t N)
if (isNumeric!T && N <= 20)
{
    T[N][N] a;
    T[1 << N] dp;

    @safe pure nothrow @nogc
    this(const T[N][N] matrix)
    {
        a = matrix;
    }

    @safe pure nothrow @nogc
    T solve()
    {
        foreach (i; 0 .. (1 << N))
            dp[i] = 0;

        foreach (mask; 0 .. (1 << N))
        {
            int row = popcnt(mask);

            if (row >= N) continue;

            foreach (col; 0 .. N)
            {
                if ((mask & (1 << col)) == 0)
                {
                    auto next = mask | (1 << col);
                    auto val = dp[mask] + a[row][col];

                    if (val > dp[next])
                        dp[next] = val;
                }
            }
        }

        return dp[(1 << N) - 1];
    }

    private static @safe pure nothrow @nogc
    int popcnt(int x)
    {
        int c = 0;
        while (x)
        {
            c += x & 1;
            x >>= 1;
        }
        return c;
    }
}

/// =======================
/// Assignment Problem — Hungarian Algorithm (fallback for large N)
/// =======================
/// Solves maximum-weight perfect matching via the Hungarian (Kuhn-Munkres) algorithm.
/// Complexity: O(N³), suitable for N > 20.
private struct Hungarian(T, size_t N)
if (isNumeric!T)
{
    T[N * N] cost;

    T[N + 1] u, v, minv;
    size_t[N + 1] p, way;
    bool[N + 1] used;

    @safe pure nothrow @nogc
    this(const T[N][N] matrix)
    {
        foreach (i; 0 .. N)
            foreach (j; 0 .. N)
                cost[i * N + j] = -matrix[i][j];
    }

    @safe pure nothrow @nogc
    T solve()
    {
        foreach (i; 0 .. N + 1)
        {
            u[i] = v[i] = 0;
            p[i] = way[i] = 0;
            used[i] = false;
        }

        foreach (i; 1 .. N + 1)
        {
            p[0] = i;
            size_t j0 = 0;

            foreach (j; 1 .. N + 1)
                minv[j] = T.max;

            foreach (j; 0 .. N + 1)
                used[j] = false;

            do
            {
                used[j0] = true;
                auto i0 = p[j0];

                T delta = T.max;
                size_t j1 = 0;

                foreach (j; 1 .. N + 1)
                {
                    if (used[j]) continue;

                    auto cur = cost[(i0 - 1) * N + (j - 1)] - u[i0] - v[j];

                    if (cur < minv[j])
                    {
                        minv[j] = cur;
                        way[j] = j0;
                    }

                    if (minv[j] < delta)
                    {
                        delta = minv[j];
                        j1 = j;
                    }
                }

                foreach (j; 0 .. N + 1)
                {
                    if (used[j])
                    {
                        u[p[j]] += delta;
                        v[j] -= delta;
                    }
                    else
                        minv[j] -= delta;
                }

                j0 = j1;

            } while (p[j0] != 0);

            do
            {
                auto j1 = way[j0];
                p[j0] = p[j1];
                j0 = j1;
            }
            while (j0);
        }

        T res = 0;

        foreach (j; 1 .. N + 1)
            if (p[j])
                res += cost[(p[j] - 1) * N + (j - 1)];

        return res;
    }
}

/// =======================
/// HYBRID ASSIGNMENT SOLVER — Public API
/// =======================
/// Solves the maximum-weight perfect assignment problem using a hybrid strategy:
/// - For N ≤ 20: bitmask DP (O(2^N · N²))
/// - For N > 20: Hungarian algorithm (O(N³))
public struct AssignmentSolver(T, size_t N)
if (isNumeric!T)
{
    static if (N <= 20)
        BitmaskDP!(T, N) dp;
    else
        Hungarian!(T, N) hung;

    /// Initialize with a cost matrix.
    @safe pure nothrow @nogc
    this(const T[N][N] matrix)
    {
        static if (N <= 20)
            dp = BitmaskDP!(T, N)(matrix);
        else
            hung = Hungarian!(T, N)(matrix);
    }

    /// Solve for maximum assignment and return the sum.
    @safe pure nothrow @nogc
    T solveMax()
    {
        static if (N <= 20)
            return dp.solve();
        else
        {
            auto r = hung.solve();
            return -r;
        }
    }
}
