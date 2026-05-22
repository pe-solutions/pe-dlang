# Problems 101–150

[← Index](SOLUTIONS.md)

| # | Title | Approach |
|---|-------|----------|
| [101](../pe-0101/source/app.d) | Optimum Polynomial | Two approaches: finite differences (Newton forward-diff table built in-place, O(k²)) and closed-form Lagrange weights (C(k,i−1)·(−1)^(k−i) basis weights, no matrix solve) |
| [102](../pe-0102/source/app.d) | Triangle Containment | Cross-product sign test: origin inside iff all three signed areas share the same sign; CTFE-parsed coordinate file |
| [103](../pe-0103/source/app.d) | Special Subset Sums: Optimum | n=7 candidate derived from n=6 optimum {11,17,20,22,23,24}; exhaustive ±3 neighbourhood search; isSpecial checks property (ii) first (sum of k+1 smallest > sum of k largest), then all 127 subset sums distinct |
| [104](../pe-0104/source/app.d) | Pandigital Fibonacci Ends | Tail tracked mod 10⁹; leading 9 digits from fractional part of log₁₀(Fₖ) via Binet formula k·LOG_PHI−LOG_SQRT5 (avoids catastrophic cancellation of the iterative log recurrence) |
| [105](../pe-0105/source/app.d) | Special Subset Sums: Testing | Generalised isSpecial for variable-length sorted slices (7–12 elements); property-(ii) loop bound k≤(n−1)/2 from disjointness constraint \|B\|+\|C\|≤n |
| [106](../pe-0106/source/app.d) | Special Subset Sums: Meta-testing | Two approaches: standard Catalan filter C(n,2k)·(C(2k,k)/2−Catalan(k)) and ballot-sequence identity Catalan(k)=C(2k+1,k)/(2k+1); both reduce to a O(n/2)-term sum |
| [107](../pe-0107/source/app.d) | Minimal Network | Kruskal's MST on a 40-vertex adjacency matrix; union-find with path halving and union by rank; saving = total edge weight − MST weight |
| [108](../pe-0108/source/app.d) | Diophantine Reciprocals I | 1/x+1/y=1/n ⟺ (x−n)(y−n)=n²; solutions = (τ(n²)+1)/2; iterate n computing τ(n²) via trial-division factorisation until count exceeds 1000 |
| [109](../pe-0109/source/app.d) | Darts | 62 non-final dart types (S1–S20, S25, D1–D20, D25, T1–T20) + 21 finishers (doubles); 1-/2-/3-dart checkouts counted; first two darts in 3-dart are an UNORDERED pair (j≥i to avoid double-count) |
| [110](../pe-0110/source/app.d) | Diophantine Reciprocals II | Same identity; brute force infeasible — DFS over n = p1^a1·p2^a2·… (a1≥a2≥…≥1, first 15 primes) pruning n ≥ best; finds min n with τ(n²) > 7 999 999 |
| [111](../pe-0111/source/app.d) | Primes with Runs | For each digit d, enumerate 10-digit candidates with exactly nonD non-d positions (starting at nonD=1) via recursive fill; Miller-Rabin primality (witnesses {2,3,5,7,11}, deterministic ≤ 2.15·10¹²) with binary mulmod (avoids 10²⁰ overflow) |
| [112](../pe-0112/source/app.d) | Bouncy Numbers | Scan digits right-to-left: d < prev ⟹ hasUp, d > prev ⟹ hasDown; bouncy iff both; iterate n, stop when bouncy×100 = n×99 |
| [113](../pe-0113/source/app.d) | Non-bouncy Numbers | Combinatorics: n-digit increasing = C(n+8,8), decreasing = C(n+9,9)−1; hockey-stick sums to C(109,9)−1 and C(110,10)−101; subtract 9×100 repdigits counted twice |
| [114](../pe-0114/source/app.d) | Counting Block Combinations I | f(n) = ways to tile n with black (1) and red (≥3) tiles; differencing the running-sum recurrence yields f(n) = 2f(n−1)−f(n−2)+f(n−4) |
| [115](../pe-0115/source/app.d) | Counting Block Combinations II | Generalisation of #114 with minimum red length m=50; same differencing gives f(n) = 2f(n−1)−f(n−2)+f(n−m−1); find least n with f > 10⁶ |
| [116](../pe-0116/source/app.d) | Red, Green or Blue Tiles | For each colour length L ∈ {2,3,4}: g(n) = g(n−1)+g(n−L) (no separation constraint); sum g(50,L)−1 over the three colours |
| [117](../pe-0117/source/app.d) | Red, Green, and Blue Tiles | Colours may be mixed freely; f(n) = f(n−1)+f(n−2)+f(n−3)+f(n−4) (tetranacci-style recurrence) |
| [118](../pe-0118/source/app.d) | Pandigital Prime Sets | For each of 511 digit-subset masks enumerate prime-forming permutations; backtrack over all partitions of {1..9} consuming the lowest available bit first (canonical order prevents duplicate unordered sets) |
| [119](../pe-0119/source/app.d) | Digit Power Sum | Enumerate n = b^k (b ≥ 2, k ≥ 2) with digit_sum(n) = b; iterate b up to 200, powers up to 10¹⁸ with overflow guard; sort and return the 30th term |
| [120](../pe-0120/source/app.d) | Square Remainders | Binomial theorem mod a²: even n → r=2, odd n → r=2na mod a²; sawtooth maximum at n=⌊(a−1)/2⌋ gives r_max(a)=2a·⌊(a−1)/2⌋; closed-form sum over a=3..1000 |
| [121](../pe-0121/source/app.d) | Disc Game Prize Fund | DP over 15 turns: dp[k] = numerator of P(k blue) with denominator (n+1)!; transition dp[k] ← dp[k−1]+dp[k]·n (right-to-left); prize = ⌊16! / Σ_{k≥8} dp[k]⌋ |
| [122](../pe-0122/source/app.d) | Efficient Exponentiation | Star-chain IDDFS per target: depth-limited DFS with doubling bound ch[pos]≪remaining < target; star chains optimal for n ≤ 12509; sum minimum depths over k=1..200 |
| [123](../pe-0123/source/app.d) | Prime Square Remainders | Same binomial result as #120: even n → r=2, odd n → r=2n·pₙ mod pₙ²; for large n (2n < pₙ) no mod reduction needed; find first odd n with r > 10¹⁰ |
| [124](../pe-0124/source/app.d) | Ordered Radicals | Sieve-style rad(n) computation: for each prime p multiply rad[m] by p for every multiple; sort index array 1..100000 by (rad(n), n); return ns[9999] |
| [125](../pe-0125/source/app.d) | Palindromic Sums | Double loop: outer on start a, inner extends sum by one square per step; collect palindromic sums < 10⁸, sort+uniq, then sum (dedup needed — same value reachable from different starts) |
| [126](../pe-0126/source/app.d) | Cuboid Layers | C(a,b,c,n)=2(ab+bc+ca)+4(a+b+c)(n−1)+4(n−1)(n−2); count array over a≤b≤c,n≥1 with LIMIT=20000; return first value with count=1000 |
| [127](../pe-0127/source/app.d) | abc-hits | rad sieve; sort 1..N−1 by rad ascending; for each non-squarefree c iterate a in sorted order breaking when rad(a)·rad(c)≥c (monotone in sorted order); check rad(a)·rad(b)·rad(c)<c and gcd(a,b)=1 |
| [128](../pe-0128/source/app.d) | Hexagonal Tile Differences | Axial-coord analysis: only F(k)=3k²−3k+2 and L(k)=3k²+3k+1 can have PD=3; F(k): diffs {1,6(k−1),6k−1,6k,6k+1,12k+5} → PD=3 iff 6k−1,6k+1,12k+5 prime; L(k): diffs {1,6k−1,6k,12k−7,6k+5,6(k+1)} → PD=3 iff 6k−1,12k−7,6k+5 prime |
| [129](../pe-0129/source/app.d) | Repunit Divisibility | A(n) ≤ n so A(n)>10⁶ requires n>10⁶; iterate n from 10⁶+1 skipping gcd(n,10)≠1; compute A(n) via R(k)=(R(k−1)·10+1) mod n until remainder=0 |
| [130](../pe-0130/source/app.d) | Composites with Prime Repunit Property | Same A(n) recurrence; skip primes and n with gcd(n,10)≠1; collect composites where A(n) \| (n−1); sum first 25 |
| [131](../pe-0131/source/app.d) | Prime Cube Partnership | n²(n+p) perfect cube with gcd(n,p)=1 forces n=m³, n+p=(m+1)³; p=(m+1)³−m³=3m²+3m+1; count primes of this form ≤ 10⁶ |
| [132](../pe-0132/source/app.d) | Large Repunit Factors | p \| R(10⁹) iff ord_p(10) \| 10⁹ iff 10^(10⁹) ≡ 1 (mod p); modpow per prime (p=3 excluded — 10≡1 mod 3 is a false positive); sum first 40 qualifying primes |
| [133](../pe-0133/source/app.d) | Repunit Non-factors | p \| R(10^n) for some n iff ord_p(10) is 2-5-smooth; check via 10^M ≡ 1 (mod p) with M=2^16·5^7 (covers all 2-5-smooth orders <10⁵); p=3 special-cased (ord formula breaks through 3\|9); sum primes <10⁵ with 10^M ≢ 1 |
| [134](../pe-0134/source/app.d) | Prime Pair Connection | For consecutive primes (p1,p2) with 5≤p1≤10⁶ find smallest S>0 with p2\|S and S≡p1 (mod 10^len(p1)); CRT: S=p2·k, k≡p1·(p2)⁻¹ (mod m), m=10^len(p1); inverse via extended Euclidean; k≠0 since p1<m; sum all S |
| [135](../pe-0135/source/app.d) | Same Differences | x²−y²−z²=n, y=x−d, z=x−2d simplifies to n=(x−d)(5d−x); set a=x−d, b=5d−x: n=ab with 4\|(a+b) and b<3a; sieve over a, step b by 4 from first valid residue; count n<10⁶ with exactly 10 factorizations |
