# Solutions

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
| [19](../pe-0019/source/app.d) | Counting Sundays | Date library — count first-of-month Sundays 1901–2000 |
| [20](../pe-0020/source/app.d) | Factorial Digit Sum | BigInt 100!, then digit sum |
| [28](../pe-0028/source/app.d) | Number Spiral Diagonals | Closed form: (4n³ + 3n² + 8n − 9) / 6 |
| [31](../pe-0031/source/app.d) | Coin Sums | Unbounded knapsack DP |
| [38](../pe-0038/source/app.d) | Pandigital Multiples | Search n × 100002; verify 9-digit pandigital |
| [39](../pe-0039/source/app.d) | Integer Right Triangles | Closed-form a = p(p−2b) / 2(p−b) eliminates inner loop |
| [40](../pe-0040/source/app.d) | Champernowne's Constant | Concatenate integers; index positions 10⁰..10⁶ and multiply |
| [47](../pe-0047/source/app.d) | Distinct Primes Factors | Omega sieve counts distinct prime factors; scan for 4 consecutive |
| [48](../pe-0048/source/app.d) | Self Powers | BigInt Σ(nⁿ), n=1..1000, mod 10¹⁰ |
| [49](../pe-0049/source/app.d) | Prime Permutations | Arithmetic progression step 3330 among digit-permutation primes |
| [50](../pe-0050/source/app.d) | Consecutive Prime Sum | Sliding sum of consecutive primes; track longest prime-valued sum |
| [55](../pe-0055/source/app.d) | Lychrel Numbers | Reverse-and-add up to 50 times; no palindrome ⇒ Lychrel |
| [56](../pe-0056/source/app.d) | Powerful Digit Sum | Maximise digit sum of aᵇ (BigInt) for a, b < 100 |
| [60](../pe-0060/source/app.d) | Prime Pair Sets | 5-clique in prime-pair graph: any two concatenate to a prime; primes from euler.math.sieve(), CTFE-baked |
| [63](../pe-0063/source/app.d) | Powerful Digit Counts | dⁿ has n digits iff n ≤ ⌊1 / (1 − log₁₀ d)⌋; sum over d = 1..9 |
| [76](../pe-0076/source/app.d) | Counting Summations | Partition DP — p(100) − 1 |
| [91](../pe-0091/source/app.d) | Right Triangles with Integer Coordinates | Dot-product perpendicularity check on three vertex pairs |
| [97](../pe-0097/source/app.d) | Large Non-Mersenne Prime | Modular exponentiation: 28433·2^7830457 + 1 mod 10¹⁰ |
| [98](../pe-0098/source/app.d) | Anagramic Squares | Anagram-group word pairs; for each pair try all N-digit squares as mappings, check if the induced substitution on the partner word also yields a square; groups processed largest-first with early exit |
| [206](../pe-0206/source/app.d) | Concealed Square | sqrt bounds + alternating-digit pattern check, step 10 |
| [235](../pe-0235/source/app.d) | An Arithmetic Geometric Sequence | Root-finding (TOMS 748) on s(5000, r) + 6·10¹¹ = 0; closed-form arithmetico-geometric sum |
| [345](../pe-0345/source/app.d) | Matrix Sum | Bitmask DP — optimal column assignment over 15×15 matrix; matrix file-imported via CTFE |
| [455](../pe-0455/source/app.d) | Powers With Trailing Digits | Fixed-point iteration k = nᵏ mod 10⁹ until stable |
| [800](../pe-0800/source/app.d) | Hybrid Integers | Log-space: q·log p + p·log q ≤ E·log B; binary search on q |
| [808](../pe-0808/source/app.d) | Reversible Prime Squares | Find primes p where both p² and rev(p²) are squares of primes |
| [820](../pe-0820/source/app.d) | Nth Digit of Reciprocals | nth digit of 1/k = (10ⁿ mod 10k) / k via modular exponentiation |
| [831](../pe-0831/source/app.d) | Triple Product | Polynomial g(m) = (81m⁵ + 765m⁴) / 40 via interpolation; compute g(142857) as BigInt, encode in base 7, return leading 10 digits |
| [849](../pe-0849/source/app.d) | The Tournament | DP score distribution over 100 rounds, mod 10⁹+7 |
| [940](../pe-0940/source/app.d) | Two-Dimensional Recurrence | Matrix exponentiation on two coupled recurrences; sum A(f_i, f_j) over 2 ≤ i, j ≤ 50 with Fibonacci indices |
| [974](../pe-0974/source/app.d) | Very Odd Numbers | DP over (residue mod 105, odd-digit parity bitmask) to locate target length; suffix-count table for greedy digit-by-digit reconstruction |
