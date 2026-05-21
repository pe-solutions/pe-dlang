module euler.rat;

import std.format : format;

// Exact rational number: always reduced, denominator always positive.
// Intermediate long overflow is possible for very large numerators/denominators;
// use BigInt-backed arithmetic if that becomes an issue.
struct Rat {
    long n = 0;
    long d = 1;

    this(long num, long den) pure nothrow @nogc {
        assert(den != 0);
        if (den < 0) { num = -num; den = -den; }
        immutable g = gcd(num < 0 ? -num : num, den);
        n = num / g;
        d = den / g;
    }

    Rat opBinary(string op)(Rat rhs) const pure nothrow @nogc {
        static if      (op == "+") return Rat(n * rhs.d + rhs.n * d, d * rhs.d);
        else static if (op == "-") return Rat(n * rhs.d - rhs.n * d, d * rhs.d);
        else static if (op == "*") return Rat(n * rhs.n, d * rhs.d);
        else static if (op == "/") { assert(rhs.n != 0); return Rat(n * rhs.d, d * rhs.n); }
        else static assert(false, "Rat: unsupported operator " ~ op);
    }

    bool opEquals(Rat rhs) const pure nothrow @nogc {
        return n == rhs.n && d == rhs.d;
    }

    int opCmp(Rat rhs) const pure nothrow @nogc {
        immutable long lhs = n * rhs.d, rhsv = rhs.n * d;
        return lhs < rhsv ? -1 : lhs > rhsv ? 1 : 0;
    }

    bool isInteger() const pure nothrow @nogc { return d == 1; }

    double toDouble() const pure nothrow @nogc { return cast(double)n / cast(double)d; }

    string toString() const pure {
        return d == 1 ? format!"%d"(n) : format!"%d/%d"(n, d);
    }
}

private long gcd(long a, long b) pure nothrow @nogc {
    while (b) { immutable t = b; b = a % b; a = t; }
    return a;
}

unittest {
    // Construction and GCD reduction
    assert(Rat(6, 4)  == Rat(3, 2));
    assert(Rat(0, 7)  == Rat(0, 1));
    assert(Rat(0, 7).n == 0 && Rat(0, 7).d == 1);

    // Sign canonicalization: denominator always positive
    assert(Rat(-4, -2) == Rat(2,  1));
    assert(Rat( 4, -2) == Rat(-2, 1));
    assert(Rat(-4, -2).d == 1);
    assert(Rat( 4, -2).n == -2);

    // Addition
    assert(Rat(1, 2) + Rat(1, 3) == Rat(5, 6));
    assert(Rat(1, 6) + Rat(1, 6) == Rat(1, 3));

    // Subtraction
    assert(Rat(3, 4) - Rat(1, 4) == Rat(1, 2));
    assert(Rat(1, 2) - Rat(1, 2) == Rat(0, 1));

    // Multiplication
    assert(Rat(2, 3) * Rat(3, 4)  == Rat(1, 2));
    assert(Rat(-1, 2) * Rat(2, 3) == Rat(-1, 3));

    // Division
    assert(Rat(2, 3) / Rat(4, 3) == Rat(1, 2));
    assert(Rat(1, 2) / Rat(3, 4) == Rat(2, 3));

    // Comparison
    assert(Rat(1, 3) < Rat(1, 2));
    assert(Rat(1, 2) > Rat(1, 3));
    assert(Rat(2, 4) == Rat(1, 2));
    assert(Rat(-1, 2) < Rat(1, 2));

    // isInteger
    assert( Rat(4, 2).isInteger);
    assert(!Rat(3, 2).isInteger);
    assert( Rat(0, 5).isInteger);

    // toDouble — 0.25 is exactly representable in IEEE 754
    assert(Rat(1, 4).toDouble == 0.25);

    // toString
    assert(Rat( 3, 1).toString == "3");
    assert(Rat( 3, 2).toString == "3/2");
    assert(Rat(-1, 3).toString == "-1/3");
    assert(Rat( 0, 5).toString == "0");
}
