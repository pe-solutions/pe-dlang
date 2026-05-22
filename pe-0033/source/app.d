// Digit Cancelling Fractions
// https://projecteuler.net/problem=33

import euler.common : runSolution;

auto solve()
{
    import std.numeric : gcd;
    int numProd = 1, denProd = 1;

    foreach (n; 10 .. 100)
    {
        if (n % 10 == 0) continue;
        foreach (d; n + 1 .. 100)
        {
            if (d % 10 == 0) continue;
            immutable int na = n / 10, nb = n % 10;
            immutable int da = d / 10, db = d % 10;

            // Identify which shared digit can be cancelled, and the resulting cn/cd.
            // if/else: for valid 2-digit pairs na==da and nb==db both force n==d (excluded).
            int cn = -1, cd = -1;
            if      (na == da) { cn = nb; cd = db; }
            else if (na == db) { cn = nb; cd = da; }
            else if (nb == da) { cn = na; cd = db; }
            else if (nb == db) { cn = na; cd = da; }

            // Cross-multiply: cn/cd == n/d iff n*cd == d*cn.
            if (cn > 0 && n * cd == d * cn)
            {
                numProd *= n;
                denProd *= d;
            }
        }
    }

    return denProd / gcd(numProd, denProd);
}

void main() { runSolution!(solve)(33); }
