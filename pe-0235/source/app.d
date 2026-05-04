// An Arithmetic Geometric Sequence
// https://projecteuler.net/problem=235

import std.format   : format;
import std.math     : abs, pow;
import euler.common : runSolution;
import euler.numerics : Solver, Method;

// s(n,r) = Σ_{k=1}^{n} (900-3k)·r^(k-1) = 900·G1 - 3·G2
// G1 = (rⁿ-1)/(r-1),  G2 = (1-(n+1)·rⁿ+n·rⁿ⁺¹)/(r-1)²;  r=1: G1=n, G2=n(n+1)/2
double s(ulong n, double r) pure nothrow @nogc @safe
{
    immutable double nf = cast(double) n;
    if (abs(r - 1.0) < 1e-14)
        return 900.0 * nf - 3.0 * nf * (nf + 1.0) / 2.0;
    immutable double d  = r - 1.0;
    immutable double rn = pow(r, nf);
    immutable double g1 = (rn - 1.0) / d;
    immutable double g2 = (1.0 - (nf + 1.0) * rn + nf * rn * r) / (d * d);
    return 900.0 * g1 - 3.0 * g2;
}

auto solve()
{
    // bracket: s(5000,1.0)+6e11 > 0 (exact), s(5000,1.01)+6e11 < 0 (dominant negative tail)
    immutable double root = Solver(
            Method.Toms748, 1.0, 1.01,
            (double r) pure nothrow @nogc => s(5000, r) + 600_000_000_000.0)
        .solve()
        .root;
    return format("%.12f", root);
}

void main() { runSolution!(solve, 235)(); }
