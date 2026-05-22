// Square Remainders
// https://projecteuler.net/problem=120

import euler.common : runSolution;

auto solve() {
    // Binomial theorem mod a²: only k=0 and k=1 terms survive.
    //   n even: (a-1)^n + (a+1)^n ≡ 2            (mod a²)
    //   n odd:  (a-1)^n + (a+1)^n ≡ 2na          (mod a²)
    // Maximising 2na mod a² over odd n ≥ 1 gives the sawtooth peak:
    //   r_max(a) = 2a · floor((a-1)/2)
    long total = 0;
    foreach (a; 3 .. 1001)
        total += 2L * a * ((a - 1) / 2);
    return total;
}

void main() { runSolution!(solve)(120); }
