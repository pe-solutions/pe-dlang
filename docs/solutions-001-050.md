# Problems 1–50

[← Index](SOLUTIONS.md)

| # | Title | Approach |
|---|-------|----------|
| [1](../pe-0001/source/app.d) | Multiples of 3 or 5 | Range filter and sum |
| [2](../pe-0002/source/app.d) | Even Fibonacci Numbers | Even-only recurrence E(n) = 4·E(n−1) + E(n−2), starting 2, 8 — skips all odd terms |
| [3](../pe-0003/source/app.d) | Largest Prime Factor | Trial-division factorisation |
| [4](../pe-0004/source/app.d) | Largest Palindrome Product | Cartesian product of 3-digit numbers, palindrome filter |
| [5](../pe-0005/source/app.d) | Smallest Multiple | LCM reduction over 1..20 |
| [6](../pe-0006/source/app.d) | Sum Square Difference | (Σn)² − Σ(n²) via range pipelines |
| [7](../pe-0007/source/app.d) | 10001st Prime | Sieve bounded by Rosser's theorem p_n < n(ln n + ln ln n) |
| [8](../pe-0008/source/app.d) | Largest Product in a Series | Sliding 13-digit window, maximise product; digit string file-imported, entire solve CTFE (0 ms) |
| [9](../pe-0009/source/app.d) | Special Pythagorean Triplet | Nested search with a+b+c=1000, a²+b²=c² |
| [10](../pe-0010/source/app.d) | Summation of Primes | Trial division filter and sum below 2M |
| [11](../pe-0011/source/app.d) | Largest Product in a Grid | 4-direction scan (right, down, two diagonals); reverse directions omitted as redundant; grid file-imported, entire solve CTFE (0 ms) |
| [12](../pe-0012/source/app.d) | Highly Divisible Triangular Number | Multiplicative divisor count: d(T_n) = d(a)·d(b) for the coprime pair from n·(n+1)/2 |
| [13](../pe-0013/source/app.d) | Large Sum | BigInt sum of 100 fifty-digit numbers; extract leading 10 digits (computed at compile time via CTFE) |
| [14](../pe-0014/source/app.d) | Longest Collatz Sequence | Memoised iterative Collatz chain |
| [15](../pe-0015/source/app.d) | Lattice Paths | Combinatorics — C(2n, n) = C(40, 20) |
| [16](../pe-0016/source/app.d) | Power Digit Sum | BigInt 2^1000, convert to string, sum digits |
| [17](../pe-0017/source/app.d) | Number Letter Counts | Lookup tables for ones/teens and tens; recurse for hundreds with British "and" rule |
| [18](../pe-0018/source/app.d) | Maximum Path Sum I | Bottom-up DP: collapse triangle from base, each cell becomes value + max of two children; CTFE-parsed triangle file |
| [19](../pe-0019/source/app.d) | Counting Sundays | Date library — count first-of-month Sundays 1901–2000 |
| [20](../pe-0020/source/app.d) | Factorial Digit Sum | BigInt 100!, then digit sum |
| [21](../pe-0021/source/app.d) | Amicable Numbers | Additive sieve for sum-of-proper-divisors up to 10 000; filter a where d(d(a)) = a and d(a) ≠ a |
| [22](../pe-0022/source/app.d) | Names Scores | Strip quotes, split on comma, sort; score = position × Σ(c−'A'+1); names file-imported |
| [23](../pe-0023/source/app.d) | Non-Abundant Sums | Additive sieve for sum-of-proper-divisors; collect abundant numbers; mark all pairwise sums; sum unmarked integers ≤ 28123 |
| [24](../pe-0024/source/app.d) | Lexicographic Permutations | Advance through 999 999 `nextPermutation` steps from `[0..9]`; join digit strings |
| [25](../pe-0025/source/app.d) | 1000-digit Fibonacci Number | Binet's formula: first n where n·log10(φ) − ½·log10(5) ≥ 999; closed-form ceil, 0 ms |
| [26](../pe-0026/source/app.d) | Reciprocal Cycles | Long-division remainder tracking per d; `maxElement!cycleLength` over `iota(2, 1000)` |
| [27](../pe-0027/source/app.d) | Quadratic Primes | Sieve + parity pruning (a and b share parity so f(1) can be an odd prime); incremental f(n) update in inner loop |
| [28](../pe-0028/source/app.d) | Number Spiral Diagonals | Closed form: (4n³ + 3n² + 8n − 9) / 6 |
| [29](../pe-0029/source/app.d) | Distinct Powers | Reduce a^b to minBase^(k·b); count distinct (base, exponent) pairs in a bool bitmap — no BigInt needed |
| [30](../pe-0030/source/app.d) | Digit Fifth Powers | Precomputed digit⁵ table; `iota(2, 6×9⁵).filter!(...).sum` — upper bound from 7×9⁵ being only 6 digits |
| [31](../pe-0031/source/app.d) | Coin Sums | Unbounded knapsack DP |
| [32](../pe-0032/source/app.d) | Pandigital Products | Bitmask per-digit tracking (bits 1–9); only 1+4+4 and 2+3+4 digit splits total 9; `digitMask` sum == `0x3FE` guards overlap and full coverage; `bool[10_000]` deduplicates products |
| [33](../pe-0033/source/app.d) | Digit Cancelling Fractions | 4-way digit-share test (if/else); cross-multiply n×cd == d×cn; trivial cases (na==da, nb==db) self-exclude by forcing n==d; GCD-reduce the product |
| 34 | Digit Factorials | |
| 35 | Circular Primes | |
| 36 | Double-base Palindromes | |
| 37 | Truncatable Primes | |
| [38](../pe-0038/source/app.d) | Pandigital Multiples | Search n × 100002; verify 9-digit pandigital |
| [39](../pe-0039/source/app.d) | Integer Right Triangles | Closed-form a = p(p−2b) / 2(p−b) eliminates inner loop |
| [40](../pe-0040/source/app.d) | Champernowne's Constant | Concatenate integers; index positions 10⁰..10⁶ and multiply |
| [41](../pe-0041/source/app.d) | Pandigital Prime | n(n+1)/2 divisible by 3 for n=2,3,5,6,8,9 → only n=4,7 are candidates; enumerate 5040+24 permutations via `nextPermutation`, take max prime |
| [42](../pe-0042/source/app.d) | Coded Triangle Numbers | n triangular iff √(1+8n) is integer (`isPerfectSquare`); `splitter(',').count!` over file-imported word list; non-alpha chars (quotes) silently skipped |
| [43](../pe-0043/source/app.d) | Sub-string Divisibility | DFS over 0–9 pandigitals; checks each 3-digit window constraint as it completes (depth 3–9) — prunes to ~O(1) paths vs 10! brute force |
| [44](../pe-0044/source/app.d) | Pentagon Numbers | Outer loop over k, inner j breaks when pj gap ≥ best; `isPent` via `24n+1` perfect-square + `(√+1) % 6 == 0` |
| [45](../pe-0045/source/app.d) | Triangular, Pentagonal, and Hexagonal | Every H_n = n(2n−1) is triangular (= T_{2n−1}); iterate hexagonals from n=144, test pentagonality via `24n+1` perfect-square check |
| [46](../pe-0046/source/app.d) | Goldbach's Other Conjecture | Sieve; for each odd composite n test k=1,2,… until n−2k² is prime; first n with no valid k is the answer |
| [47](../pe-0047/source/app.d) | Distinct Primes Factors | Omega sieve counts distinct prime factors; scan for 4 consecutive |
| [48](../pe-0048/source/app.d) | Self Powers | BigInt Σ(nⁿ), n=1..1000, mod 10¹⁰ |
| [49](../pe-0049/source/app.d) | Prime Permutations | Arithmetic progression step 3330 among digit-permutation primes |
| [50](../pe-0050/source/app.d) | Consecutive Prime Sum | Sliding sum of consecutive primes; track longest prime-valued sum |
