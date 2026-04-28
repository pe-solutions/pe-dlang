// Integer Right Triangles
// https://projecteuler.net/problem=39

import euler.common : runSolution;

auto solve() {
    int maxPerimeter = 0;
    int maxCount = 0;
    foreach (int p; 12 .. 1001) {
        int count = 0;
        foreach (int b; 2 .. p / 2) {
            // From a+b+c=p and a²+b²=c², solving for a gives:
            // a = p(p-2b) / 2(p-b)
            immutable num = p * (p - 2 * b);
            immutable den = 2 * (p - b);
            if (num > 0 && num % den == 0) {
                immutable a = num / den;
                if (a < b) count++;
            }
        }
        if (count > maxCount) {
            maxCount = count;
            maxPerimeter = p;
        }
    }
    return maxPerimeter;
}

void main() { runSolution!(solve, 39)(); }
