# Problems 101–150

[← Index](SOLUTIONS.md)

| # | Title | Approach |
|---|-------|----------|
| [101](../pe-0101/source/app.d) | Optimum Polynomial | Two approaches: finite differences (Newton forward-diff table built in-place, O(k²)) and closed-form Lagrange weights (C(k,i−1)·(−1)^(k−i) basis weights, no matrix solve) |
| [102](../pe-0102/source/app.d) | Triangle Containment | Cross-product sign test: origin inside iff all three signed areas share the same sign; CTFE-parsed coordinate file |
| [103](../pe-0103/source/app.d) | Special Subset Sums: Optimum | n=7 candidate derived from n=6 optimum {11,17,20,22,23,24}; exhaustive ±3 neighbourhood search; isSpecial checks property (ii) first (sum of k+1 smallest > sum of k largest), then all 127 subset sums distinct |
| [104](../pe-0104/source/app.d) | Pandigital Fibonacci Ends | Tail tracked mod 10⁹; leading 9 digits from fractional part of log₁₀(Fₖ) via Binet formula k·LOG_PHI−LOG_SQRT5 (avoids catastrophic cancellation of the iterative log recurrence) |
| [105](../pe-0105/source/app.d) | Special Subset Sums: Testing | Generalised isSpecial for variable-length sorted slices (7–12 elements); property-(ii) loop bound k≤(n−1)/2 from disjointness constraint |B|+|C|≤n |
| [106](../pe-0106/source/app.d) | Special Subset Sums: Meta-testing | Two approaches: standard Catalan filter C(n,2k)·(C(2k,k)/2−Catalan(k)) and ballot-sequence identity Catalan(k)=C(2k+1,k)/(2k+1); both reduce to a O(n/2)-term sum |
| [107](../pe-0107/source/app.d) | Minimal Network | Kruskal's MST on a 40-vertex adjacency matrix; union-find with path halving and union by rank; saving = total edge weight − MST weight |
| [108](../pe-0108/source/app.d) | Diophantine Reciprocals I | 1/x+1/y=1/n ⟺ (x−n)(y−n)=n²; solutions = (τ(n²)+1)/2; iterate n computing τ(n²) via trial-division factorisation until count exceeds 1000 |
