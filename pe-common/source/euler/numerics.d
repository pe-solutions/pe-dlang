/**
 * Numerical methods for Project Euler solutions.
 *
 * Currently provides root-finding solvers:
 *   - Method.NewtonRaphson — derivative-based, quadratic order
 *   - Method.Brent         — bracketed, ~1.84 order
 *   - Method.Toms748       — bracketed, ~2.7 order
 *   - Method.Itp           — bracketed, minimax optimal
 */
module euler.numerics;

import std.math      : abs, pow, log2, ceil, isNaN, isInfinity;
import std.algorithm : swap;
import std.typecons  : Tuple, tuple;
import core.stdc.stdio : fprintf, stderr;

// ── Method selector ──────────────────────────────────────────────────────────

/// Selects the root-finding algorithm used by `Solver`.
enum Method
{
    /// Newton-Raphson: quadratic order, no bracket, uses numerical derivative.
    /// Initial guess is taken as the midpoint of [a, b].
    NewtonRaphson,
    /// Brent-Dekker: bracketed, ~1.84 order. Combines inverse quadratic
    /// interpolation, secant, and bisection fallback.
    Brent,
    /// TOMS 748 (Alefeld, Potra & Shi, 1995): bracketed, ~2.7 order.
    /// Uses inverse cubic interpolation with a double-secant fallback.
    Toms748,
    /// ITP (Oliveira & Takahashi, 2020): bracketed, minimax optimal.
    /// Worst-case equals bisection; typical performance is superlinear.
    Itp,
}

/// Returns a human-readable label for a Method value.
string label(Method m) pure nothrow @nogc @safe
{
    final switch (m)
    {
        case Method.NewtonRaphson: return "Newton-Raphson";
        case Method.Brent:         return "Brent-Dekker";
        case Method.Toms748:       return "TOMS 748";
        case Method.Itp:           return "ITP";
    }
}

// ── Result ───────────────────────────────────────────────────────────────────

/// Result returned by `Solver.solve`.
struct SolveResult
{
    Method method; /// The method used.
    double root;   /// Approximate root: f(root) ≈ 0.
    size_t evals;  /// Total calls to the objective function.
}

// ── Solver ───────────────────────────────────────────────────────────────────

/**
 * Configures and runs a root-finding solve for f(r) = 0 on [a, b].
 *
 * The objective function is injected via a delegate, making Solver
 * fully generic and reusable as a library component.
 *
 * All methods share the same interface: a bracket [a, b] with f(a)·f(b) < 0.
 * Newton-Raphson uses the midpoint (a+b)/2 as its initial guess.
 */
struct Solver
{
    Method method;
    double a, b;
    double delegate(double) pure nothrow @nogc func;

    this(Method method, double a, double b,
         double delegate(double) pure nothrow @nogc func) pure nothrow @nogc @safe
    {
        this.method = method;
        this.a      = a;
        this.b      = b;
        this.func   = func;
    }

    /// Runs the selected solver and returns a SolveResult.
    SolveResult solve() nothrow
    {
        double root;
        size_t evals;
        final switch (method)
        {
            case Method.NewtonRaphson: auto r = newtonRaphson(); root = r[0]; evals = r[1]; break;
            case Method.Brent:         auto r = brent();         root = r[0]; evals = r[1]; break;
            case Method.Toms748:       auto r = toms748();       root = r[0]; evals = r[1]; break;
            case Method.Itp:           auto r = itp();           root = r[0]; evals = r[1]; break;
        }
        return SolveResult(method, root, evals);
    }

    pragma(inline, true)
    double eval(double x) pure nothrow @nogc { return func(x); }

    pragma(inline, true)
    double diff(double x) pure nothrow @nogc
    {
        enum double h = 1e-7;
        return (eval(x + h) - eval(x - h)) / (2.0 * h);
    }

    pragma(inline, true)
    static double clamp(double x, double lo, double hi) pure nothrow @nogc @safe
    {
        import std.math : fmin, fmax;
        return fmax(lo, fmin(hi, x));
    }

    pragma(inline, true)
    static bool inBracket(double a, double b, double x) pure nothrow @nogc @safe
    {
        return (a < x && x < b) || (b < x && x < a);
    }

    pragma(inline, true)
    static void updateBracket(ref double a, ref double b,
                              ref double fa, ref double fb,
                              double c, double fc) pure nothrow @nogc @safe
    {
        if (fa * fc < 0.0) { b = c; fb = fc; }
        else               { a = c; fa = fc; }
    }

    private Tuple!(double, size_t) newtonRaphson() nothrow
    {
        enum double TOL = 1e-15;
        double x     = (a + b) / 2.0;  // initial guess: bracket midpoint
        size_t evals = 0;
        foreach (i; 0 .. 300)
        {
            immutable double fx  = eval(x); evals += 1;
            immutable double dfx = diff(x); evals += 2;
            double x1 = x - fx / dfx;
            if (abs(x1 - x) < TOL) return tuple(x1, evals);
            x = x1;
            if (i == 299) fprintf(stderr, "Newton-Raphson: max iterations reached\n");
        }
        return tuple(x, evals);
    }

    private Tuple!(double, size_t) brent() pure nothrow @nogc
    {
        enum double TOL = 1e-15;
        double a_ = a, b_ = b;
        double fa = eval(a_), fb = eval(b_);
        size_t evals = 2;
        assert(fa * fb < 0.0);
        if (abs(fa) < abs(fb)) { swap(a_, b_); swap(fa, fb); }
        double c = a_, fc = fa, d = 0.0;
        bool mflag = true;
        foreach (_; 0 .. 300)
        {
            if (abs(fb) < TOL || abs(b_ - a_) < TOL) break;
            double s_;
            if (fa != fc && fb != fc)
                s_ = a_*fb*fc/((fa-fb)*(fa-fc))
                   + b_*fa*fc/((fb-fa)*(fb-fc))
                   + c *fa*fb/((fc-fa)*(fc-fb));
            else
                s_ = b_ - fb*(b_-a_)/(fb-fa);
            immutable double mid  = (3.0*a_ + b_) / 4.0;
            immutable bool   inIv = (a_ < b_ && mid < s_ && s_ < b_)
                                 || (b_ < a_ && b_ < s_ && s_ < mid);
            if (!inIv
                || (mflag  && abs(s_-b_) >= abs(b_-c)/2.0)
                || (!mflag && abs(s_-b_) >= abs(c-d)/2.0)
                || (mflag  && abs(b_-c)  < TOL)
                || (!mflag && abs(c-d)   < TOL))
            { mflag = true; s_ = (a_+b_)/2.0; }
            else mflag = false;
            immutable double fs = eval(s_); evals++;
            d = c; c = b_; fc = fb;
            if (fa*fs < 0.0) { b_ = s_; fb = fs; } else { a_ = s_; fa = fs; }
            if (abs(fa) < abs(fb)) { swap(a_, b_); swap(fa, fb); }
        }
        return tuple(b_, evals);
    }

    private Tuple!(double, size_t) toms748() pure nothrow @nogc
    {
        enum double TOL = 1e-15;
        enum double MU  = 0.5;
        size_t evals    = 2;

        static double ipq(double a_, double fa_, double b_, double fb_,
                          double d_, double fd_) pure nothrow @nogc @safe
        {
            return a_*fb_*fd_/((fa_-fb_)*(fa_-fd_))
                 + b_*fa_*fd_/((fb_-fa_)*(fb_-fd_))
                 + d_*fa_*fb_/((fd_-fa_)*(fd_-fb_));
        }

        double a_ = a, b_ = b;
        double fa = eval(a_), fb = eval(b_);
        assert(fa * fb < 0.0);

        double c = clamp(a_ + (b_-a_)*fa/(fa-fb),
                         a_ + MU*abs(b_-a_), b_ - MU*abs(b_-a_));
        immutable double fc0 = eval(c); evals++;
        updateBracket(a_, b_, fa, fb, c, fc0);
        double d = c, fd = fc0;

        for (;;)
        {
            if (abs(b_ - a_) < TOL || abs(fb) < TOL) break;

            immutable double e = ipq(a_, fa, b_, fb, d, fd);
            double s_ = (isFinite(e) && inBracket(a_, b_, e))
                      ? e : a_ + (b_-a_)*fa/(fa-fb);
            s_ = clamp(s_, a_ + MU*abs(b_-a_), b_ - MU*abs(b_-a_));
            immutable double fs = eval(s_); evals++;
            updateBracket(a_, b_, fa, fb, s_, fs);
            if (abs(b_ - a_) < TOL || abs(fb) < TOL) break;

            double t = clamp(b_ - (b_-a_)*fb/(fb-fa),
                             a_ + MU*abs(b_-a_), b_ - MU*abs(b_-a_));
            immutable double ft = eval(t); evals++;
            updateBracket(a_, b_, fa, fb, t, ft);
            if (abs(b_ - a_) < TOL || abs(fb) < TOL) break;

            immutable double m  = (a_ + b_) / 2.0;
            immutable double fm = eval(m); evals++;
            d = m; fd = fm;
            updateBracket(a_, b_, fa, fb, m, fm);
        }
        return tuple(b_, evals);
    }

    private Tuple!(double, size_t) itp() pure nothrow @nogc
    {
        enum double TOL   = 1e-15;
        enum double K1    = 0.1;
        enum double K2    = 2.0;
        enum size_t N0    = 1;

        double a_ = a, b_ = b;
        double fa = eval(a_), fb = eval(b_);
        size_t evals = 2;
        assert(fa * fb < 0.0);

        immutable size_t nHalf = cast(size_t) ceil(log2((b_-a_) / (2.0*TOL)));
        immutable size_t nMax  = nHalf + N0;
        size_t j = 0;

        while (b_ - a_ > 2.0 * TOL)
        {
            immutable double xHalf = (a_ + b_) / 2.0;
            immutable double r     = TOL * pow(2.0, cast(double)(nMax-j)) - (b_-a_)/2.0;
            immutable double delta = K1 * pow(b_-a_, K2);
            immutable double xF    = a_ - fa*(b_-a_)/(fb-fa);
            immutable double diff_ = xHalf - xF;
            immutable double sigma = (diff_ > 0.0) ? 1.0 : -1.0;
            immutable double xT    = (delta <= abs(diff_)) ? xF + sigma*delta : xHalf;
            immutable double xItp  = (abs(xT-xHalf) <= r)  ? xT : xHalf - sigma*r;

            immutable double fxItp = eval(xItp); evals++;
            if (fa * fxItp < 0.0) { b_ = xItp; fb = fxItp; }
            else                   { a_ = xItp; fa = fxItp; }
            j++;
        }
        return tuple((a_+b_)/2.0, evals);
    }
}

/// Returns true if x is finite (not NaN or ±infinity).
pragma(inline, true)
bool isFinite(double x) pure nothrow @nogc @safe
{
    return !isNaN(x) && !isInfinity(x);
}
