# Solutions

## 1–50

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
| 16 | | |
| 17 | | |
| 18 | | |
| [19](../pe-0019/source/app.d) | Counting Sundays | Date library — count first-of-month Sundays 1901–2000 |
| [20](../pe-0020/source/app.d) | Factorial Digit Sum | BigInt 100!, then digit sum |
| 21 | | |
| 22 | | |
| 23 | | |
| 24 | | |
| 25 | | |
| 26 | | |
| 27 | | |
| [28](../pe-0028/source/app.d) | Number Spiral Diagonals | Closed form: (4n³ + 3n² + 8n − 9) / 6 |
| 29 | | |
| 30 | | |
| [31](../pe-0031/source/app.d) | Coin Sums | Unbounded knapsack DP |
| 32 | | |
| 33 | | |
| 34 | | |
| 35 | | |
| 36 | | |
| 37 | | |
| [38](../pe-0038/source/app.d) | Pandigital Multiples | Search n × 100002; verify 9-digit pandigital |
| [39](../pe-0039/source/app.d) | Integer Right Triangles | Closed-form a = p(p−2b) / 2(p−b) eliminates inner loop |
| [40](../pe-0040/source/app.d) | Champernowne's Constant | Concatenate integers; index positions 10⁰..10⁶ and multiply |
| 41 | | |
| 42 | | |
| 43 | | |
| 44 | | |
| 45 | | |
| 46 | | |
| [47](../pe-0047/source/app.d) | Distinct Primes Factors | Omega sieve counts distinct prime factors; scan for 4 consecutive |
| [48](../pe-0048/source/app.d) | Self Powers | BigInt Σ(nⁿ), n=1..1000, mod 10¹⁰ |
| [49](../pe-0049/source/app.d) | Prime Permutations | Arithmetic progression step 3330 among digit-permutation primes |
| [50](../pe-0050/source/app.d) | Consecutive Prime Sum | Sliding sum of consecutive primes; track longest prime-valued sum |

## 51–100

| # | Title | Approach |
|---|-------|----------|
| 51 | | |
| 52 | | |
| 53 | | |
| 54 | | |
| [55](../pe-0055/source/app.d) | Lychrel Numbers | Reverse-and-add up to 50 times; no palindrome ⇒ Lychrel |
| [56](../pe-0056/source/app.d) | Powerful Digit Sum | Maximise digit sum of aᵇ (BigInt) for a, b < 100 |
| 57 | | |
| 58 | | |
| 59 | | |
| [60](../pe-0060/source/app.d) | Prime Pair Sets | 5-clique in prime-pair graph: any two concatenate to a prime; primes from euler.math.sieve(), CTFE-baked |
| 61 | | |
| 62 | | |
| [63](../pe-0063/source/app.d) | Powerful Digit Counts | dⁿ has n digits iff n ≤ ⌊1 / (1 − log₁₀ d)⌋; sum over d = 1..9 |
| 64 | | |
| 65 | | |
| 66 | | |
| 67 | | |
| 68 | | |
| 69 | | |
| 70 | | |
| 71 | | |
| 72 | | |
| 73 | | |
| 74 | | |
| 75 | | |
| [76](../pe-0076/source/app.d) | Counting Summations | Partition DP — p(100) − 1 |
| 77 | | |
| 78 | | |
| 79 | | |
| 80 | | |
| 81 | | |
| 82 | | |
| 83 | | |
| 84 | | |
| 85 | | |
| 86 | | |
| 87 | | |
| 88 | | |
| 89 | | |
| 90 | | |
| [91](../pe-0091/source/app.d) | Right Triangles with Integer Coordinates | Dot-product perpendicularity check on three vertex pairs |
| [92](../pe-0092/source/app.d) | Square Digit Chains | Digit-DP: precompute chain terminus for sums ≤ 567; count valid numbers by prepending non-zero leading digits to suffix distributions each round |
| [93](../pe-0093/source/app.d) | Arithmetic Expressions | Try all C(10,4)=210 digit sets × 24 permutations × 64 operator combos × 5 parenthesisations; exact rational arithmetic avoids fp errors on intermediate fractions |
| [94](../pe-0094/source/app.d) | Almost Equilateral Triangles | Sides a,a,a±1 with integer area reduce to Pell-like p²−3q²=4; iterate recurrence pₙ=4pₙ₋₁−pₙ₋₂ from (2,4); perimeter = p±2 based on p mod 3 |
| [95](../pe-0095/source/app.d) | Amicable Chains | Additive sieve for sum-of-proper-divisors; cycle detection by stamping each chain node with its step index; pre-allocated path buffer avoids GC churn |
| [96](../pe-0096/source/app.d) | Su Doku | Backtracking with row/col/box bitmasks; MRV heuristic (pick cell with fewest available digits) keeps search tree tiny across all 50 puzzles |
| [97](../pe-0097/source/app.d) | Large Non-Mersenne Prime | Modular exponentiation: 28433·2^7830457 + 1 mod 10¹⁰ |
| [98](../pe-0098/source/app.d) | Anagramic Squares | Anagram-group word pairs; for each pair try all N-digit squares as mappings, check if the induced substitution on the partner word also yields a square; groups processed largest-first with early exit |
| [99](../pe-0099/source/app.d) | Largest Exponential | Compare a^b by b·log(a); find the line index with the maximum value |
| [100](../pe-0100/source/app.d) | Arranged Probability | Pell equation y²−2x²=−1 (x=2b−1, y=2n−1); iterate recurrence n'=6n−n_prev−2 until n>10¹² |

## 201–250

| # | Title | Approach |
|---|-------|----------|
| 201 | | |
| 202 | | |
| 203 | | |
| 204 | | |
| 205 | | |
| [206](../pe-0206/source/app.d) | Concealed Square | sqrt bounds + alternating-digit pattern check, step 10 |
| 207 | | |
| 208 | | |
| 209 | | |
| 210 | | |
| 211 | | |
| 212 | | |
| 213 | | |
| 214 | | |
| 215 | | |
| 216 | | |
| 217 | | |
| 218 | | |
| 219 | | |
| 220 | | |
| 221 | | |
| 222 | | |
| 223 | | |
| 224 | | |
| 225 | | |
| 226 | | |
| 227 | | |
| 228 | | |
| 229 | | |
| 230 | | |
| 231 | | |
| 232 | | |
| 233 | | |
| 234 | | |
| [235](../pe-0235/source/app.d) | An Arithmetic Geometric Sequence | Root-finding (TOMS 748) on s(5000, r) + 6·10¹¹ = 0; closed-form arithmetico-geometric sum |
| 236 | | |
| 237 | | |
| 238 | | |
| 239 | | |
| 240 | | |
| 241 | | |
| 242 | | |
| 243 | | |
| 244 | | |
| 245 | | |
| 246 | | |
| 247 | | |
| 248 | | |
| 249 | | |
| 250 | | |

## 301–350

| # | Title | Approach |
|---|-------|----------|
| 301 | | |
| 302 | | |
| 303 | | |
| 304 | | |
| 305 | | |
| 306 | | |
| 307 | | |
| 308 | | |
| 309 | | |
| 310 | | |
| 311 | | |
| 312 | | |
| 313 | | |
| 314 | | |
| 315 | | |
| 316 | | |
| 317 | | |
| 318 | | |
| 319 | | |
| 320 | | |
| 321 | | |
| 322 | | |
| 323 | | |
| 324 | | |
| 325 | | |
| 326 | | |
| 327 | | |
| 328 | | |
| 329 | | |
| 330 | | |
| 331 | | |
| 332 | | |
| 333 | | |
| 334 | | |
| 335 | | |
| 336 | | |
| 337 | | |
| 338 | | |
| 339 | | |
| 340 | | |
| 341 | | |
| 342 | | |
| 343 | | |
| 344 | | |
| [345](../pe-0345/source/app.d) | Matrix Sum | Bitmask DP — optimal column assignment over 15×15 matrix; matrix file-imported via CTFE |
| 346 | | |
| 347 | | |
| 348 | | |
| 349 | | |
| 350 | | |

## 451–500

| # | Title | Approach |
|---|-------|----------|
| 451 | | |
| 452 | | |
| 453 | | |
| 454 | | |
| [455](../pe-0455/source/app.d) | Powers With Trailing Digits | Fixed-point iteration k = nᵏ mod 10⁹ until stable |
| 456 | | |
| 457 | | |
| 458 | | |
| 459 | | |
| 460 | | |
| 461 | | |
| 462 | | |
| 463 | | |
| 464 | | |
| 465 | | |
| 466 | | |
| 467 | | |
| 468 | | |
| 469 | | |
| 470 | | |
| 471 | | |
| 472 | | |
| 473 | | |
| 474 | | |
| 475 | | |
| 476 | | |
| 477 | | |
| 478 | | |
| 479 | | |
| 480 | | |
| 481 | | |
| 482 | | |
| 483 | | |
| 484 | | |
| 485 | | |
| 486 | | |
| 487 | | |
| 488 | | |
| 489 | | |
| 490 | | |
| 491 | | |
| 492 | | |
| 493 | | |
| 494 | | |
| 495 | | |
| 496 | | |
| 497 | | |
| 498 | | |
| 499 | | |
| 500 | | |

## 751–800

| # | Title | Approach |
|---|-------|----------|
| 751 | | |
| 752 | | |
| 753 | | |
| 754 | | |
| 755 | | |
| 756 | | |
| 757 | | |
| 758 | | |
| 759 | | |
| 760 | | |
| 761 | | |
| 762 | | |
| 763 | | |
| 764 | | |
| 765 | | |
| 766 | | |
| 767 | | |
| 768 | | |
| 769 | | |
| 770 | | |
| 771 | | |
| 772 | | |
| 773 | | |
| 774 | | |
| 775 | | |
| 776 | | |
| 777 | | |
| 778 | | |
| 779 | | |
| 780 | | |
| 781 | | |
| 782 | | |
| 783 | | |
| 784 | | |
| 785 | | |
| 786 | | |
| 787 | | |
| 788 | | |
| 789 | | |
| 790 | | |
| 791 | | |
| 792 | | |
| 793 | | |
| 794 | | |
| 795 | | |
| 796 | | |
| 797 | | |
| 798 | | |
| 799 | | |
| [800](../pe-0800/source/app.d) | Hybrid Integers | Log-space: q·log p + p·log q ≤ E·log B; binary search on q |

## 801–850

| # | Title | Approach |
|---|-------|----------|
| 801 | | |
| 802 | | |
| 803 | | |
| 804 | | |
| 805 | | |
| 806 | | |
| 807 | | |
| [808](../pe-0808/source/app.d) | Reversible Prime Squares | Find primes p where both p² and rev(p²) are squares of primes |
| 809 | | |
| 810 | | |
| 811 | | |
| 812 | | |
| 813 | | |
| 814 | | |
| 815 | | |
| 816 | | |
| 817 | | |
| 818 | | |
| 819 | | |
| [820](../pe-0820/source/app.d) | Nth Digit of Reciprocals | nth digit of 1/k = (10ⁿ mod 10k) / k via modular exponentiation |
| 821 | | |
| 822 | | |
| 823 | | |
| 824 | | |
| 825 | | |
| 826 | | |
| 827 | | |
| 828 | | |
| 829 | | |
| 830 | | |
| [831](../pe-0831/source/app.d) | Triple Product | Polynomial g(m) = (81m⁵ + 765m⁴) / 40 via interpolation; compute g(142857) as BigInt, encode in base 7, return leading 10 digits |
| 832 | | |
| 833 | | |
| 834 | | |
| 835 | | |
| 836 | | |
| 837 | | |
| 838 | | |
| 839 | | |
| 840 | | |
| 841 | | |
| 842 | | |
| 843 | | |
| 844 | | |
| 845 | | |
| 846 | | |
| 847 | | |
| 848 | | |
| [849](../pe-0849/source/app.d) | The Tournament | DP score distribution over 100 rounds, mod 10⁹+7 |
| 850 | | |

## 901–950

| # | Title | Approach |
|---|-------|----------|
| 901 | | |
| 902 | | |
| 903 | | |
| 904 | | |
| 905 | | |
| 906 | | |
| 907 | | |
| 908 | | |
| 909 | | |
| 910 | | |
| 911 | | |
| 912 | | |
| 913 | | |
| 914 | | |
| 915 | | |
| 916 | | |
| 917 | | |
| 918 | | |
| 919 | | |
| 920 | | |
| 921 | | |
| 922 | | |
| 923 | | |
| 924 | | |
| 925 | | |
| 926 | | |
| 927 | | |
| 928 | | |
| 929 | | |
| 930 | | |
| 931 | | |
| 932 | | |
| 933 | | |
| 934 | | |
| 935 | | |
| 936 | | |
| 937 | | |
| 938 | | |
| 939 | | |
| [940](../pe-0940/source/app.d) | Two-Dimensional Recurrence | Matrix exponentiation on two coupled recurrences; sum A(f_i, f_j) over 2 ≤ i, j ≤ 50 with Fibonacci indices |
| 941 | | |
| 942 | | |
| 943 | | |
| 944 | | |
| 945 | | |
| 946 | | |
| 947 | | |
| 948 | | |
| 949 | | |
| 950 | | |

## 951–1000

| # | Title | Approach |
|---|-------|----------|
| 951 | | |
| 952 | | |
| 953 | | |
| 954 | | |
| 955 | | |
| 956 | | |
| 957 | | |
| 958 | | |
| 959 | | |
| 960 | | |
| 961 | | |
| 962 | | |
| 963 | | |
| 964 | | |
| 965 | | |
| 966 | | |
| 967 | | |
| 968 | | |
| 969 | | |
| 970 | | |
| 971 | | |
| 972 | | |
| 973 | | |
| [974](../pe-0974/source/app.d) | Very Odd Numbers | DP over (residue mod 105, odd-digit parity bitmask) to locate target length; suffix-count table for greedy digit-by-digit reconstruction |
| 975 | | |
| 976 | | |
| 977 | | |
| 978 | | |
| 979 | | |
| 980 | | |
| 981 | | |
| 982 | | |
| 983 | | |
| 984 | | |
| 985 | | |
| 986 | | |
| 987 | | |
| 988 | | |
| 989 | | |
| 990 | | |
| 991 | | |
| 992 | | |
| 993 | | |
| 994 | | |
| 995 | | |
| 996 | | |
| 997 | | |
| 998 | | |
| 999 | | |
| 1000 | | |
