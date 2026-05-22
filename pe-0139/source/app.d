// Pythagorean Tiles
// https://projecteuler.net/problem=139

import euler.common : runSolution;

// Four copies of a right triangle (legs a,b; hypotenuse c) tile a square of
// side c with a central hole of side |a−b|; tiling works iff |a−b| | c.
// For primitive triples (a=m²−n², b=2mn, c=m²+n²): c ≡ 2n(m+n) (mod |a−b|),
// and since gcd(|a−b|,n)=1, gcd(|a−b|,m+n)=1 (m+n always odd), and |a−b| is
// odd, the condition reduces to |a−b|=1, i.e. (m−n)²−2n²=±1 (Pell).
// The two sign sequences interleave into m_{k+1}=2mₖ+m_{k−1} (m₀=1, m₁=2)
// with nₖ=m_{k−1}; primitive perimeter p=2mₖ(mₖ+nₖ); count ⌊(N−1)/p⌋ per p.
auto solve() pure nothrow @nogc {
    enum long N = 100_000_000;
    long count = 0;
    long prev = 1, curr = 2;
    while (true) {
        immutable long p = 2*curr*(curr + prev);
        if (p >= N) break;
        count += (N - 1) / p;
        immutable long next = 2*curr + prev;
        prev = curr;
        curr = next;
    }
    return count;
}

void main() { runSolution!(solve)(139); }
