// Prime Cube Partnership
// https://projecteuler.net/problem=131

import euler.common : runSolution;

auto solve() {
    import euler.math : isPrime;

    // n³ + n²p = n²(n+p) is a perfect cube.
    // With gcd(n,p)=1: need n² and n+p both perfect cubes.
    //   n=m³, n+p=(m+1)³  →  p = (m+1)³ − m³ = 3m²+3m+1.
    //   (gcd(n,p)=p case yields n=0, excluded.)
    // Count primes of the form 3m²+3m+1 ≤ 10^6.
    int count = 0;
    for (long m = 1; ; m++) {
        immutable long p = 3*m*m + 3*m + 1;
        if (p > 1_000_000) break;
        if (isPrime(p)) count++;
    }
    return count;
}

void main() { runSolution!(solve)(131); }
