# Problems 51–100

[← Index](SOLUTIONS.md)

| # | Title | Approach |
|---|-------|----------|
| [51](../pe-0051/source/app.d) | Prime Digit Replacements | Sieve to 1 M; for each prime try all 2ⁿ−1 position subsets as wildcard; replace with 0–9 via `val += (r − digs[i])·pow10[i]`; skip leading-zero replacements; return smallest prime when count ≥ 8 |
| [52](../pe-0052/source/app.d) | Permuted Multiples | Nibble-packed `digitFreq` encodes digit multiset as a `ulong`; iterate only the valid band `[10^(d−1), 10^d/6]` where x and 6x share digit count; single equality check per multiple |
| [53](../pe-0053/source/app.d) | Combinatoric Selections | Pascal's triangle in a single `int[101]` row updated right-to-left; cap at 1 000 001 prevents overflow and BigInt; count entries ≥ cap per row |
| [54](../pe-0054/source/app.d) | Poker Hands | Frequency-table hand evaluator; insertion-sort 5 cards by `(cnt desc, val desc)` for canonical tiebreaker order; pack rank + nibbles into one `int`; direct fixed-offset line parsing avoids split |
| [55](../pe-0055/source/app.d) | Lychrel Numbers | Reverse-and-add up to 50 times; no palindrome ⇒ Lychrel |
| [56](../pe-0056/source/app.d) | Powerful Digit Sum | Maximise digit sum of aᵇ (BigInt) for a, b < 100 |
| [57](../pe-0057/source/app.d) | Square Root Convergents | Recurrence n' = n + 2d, d' = n + d on BigInt; track digit-count via `tn`/`td` (smallest power of 10 exceeding n/d) — `tn > td` iff n has more digits; avoids string conversion entirely |
| [58](../pe-0058/source/app.d) | Spiral Primes | Deterministic Miller-Rabin (witnesses {2,3,5,7}) on ring-k diagonal corners s²−d, s²−2d, s²−3d (s=2k+1, d=s−1); stop when 10·primes < 1+4k |
| [59](../pe-0059/source/app.d) | XOR Decryption | Frequency analysis per sub-stream: split cipher by position mod 3; for each of the 3 positions try all 26 lowercase candidates, pick the one maximising common-English-char count; CTFE-parsed cipher embedded via `import("data/cipher.txt")` |
| [60](../pe-0060/source/app.d) | Prime Pair Sets | 5-clique in prime-pair graph: any two concatenate to a prime; primes from euler.math.sieve(), CTFE-baked |
| [61](../pe-0061/source/app.d) | Cyclical Figurate Numbers | Generate 4-digit k-gonal numbers for k=3..8; per-type lookup table keyed by first-two-digit prefix; DFS fixes triangle as chain head, extends with each remaining type matching the current tail; cycle closes when last2 of 6th number equals first2 of 1st |
| [62](../pe-0062/source/app.d) | Cubic Permutations | Group cubes by `digitFreq` fingerprint (nibble-per-digit, same value iff digit permutation); two AAs track count and smallest cube per group; return smallest when count reaches 5 |
| [63](../pe-0063/source/app.d) | Powerful Digit Counts | dⁿ has n digits iff n ≤ ⌊1 / (1 − log₁₀ d)⌋; sum over d = 1..9 |
| [64](../pe-0064/source/app.d) | Odd Period Square Roots | CF expansion of √n: iterate m←d·a−m, d←(n−m²)/d, a←⌊(a₀+m)/d⌋ until a=2a₀; period length is the step count; skip perfect squares; count N≤10000 with odd period |
| [65](../pe-0065/source/app.d) | Convergents of e | CF coefficients of e: a(k)=2k/3 when k%3=0, else 1; apply h_n=a_n·h_{n−1}+h_{n−2} recurrence 99 times on BigInt starting from h₁=2; sum digits of h₁₀₀ |
| [66](../pe-0066/source/app.d) | Diophantine Equation | Pell equation x²−Dy²=1: for each non-square D≤1000 step CF convergents of √D (same m/d/a recurrence as #64) accumulating numerator h and denominator k on BigInt until h²−Dk²=1; return D with the largest minimal x |
| [67](../pe-0067/source/app.d) | Maximum Path Sum II | Same bottom-up DP as #18; CTFE-parsed 100-row triangle file |
| [68](../pe-0068/source/app.d) | Magic 5-gon Ring | Fix inner pentagon as 5 values from {1..9} (forces 10 outer ⇒ 16-digit string); S=(sumInner+55)/5; outer[i]=S−inner[i]−inner[i+1] must cover {1..10}∖inner; bitmask dedup; read clockwise from smallest outer node; keep lexicographic max |
| 69 | Totient Maximum | |
| 70 | Totient Permutation | |
| 71 | Ordered Fractions | |
| 72 | Counting Fractions | |
| 73 | Counting Fractions in a Range | |
| 74 | Digit Factorial Chains | |
| 75 | Singular Integer Right Triangles | |
| [76](../pe-0076/source/app.d) | Counting Summations | Partition DP — p(100) − 1 |
| 77 | Prime Summations | |
| 78 | Coin Partitions | |
| 79 | Passcode Derivation | |
| 80 | Square Root Digital Expansion | |
| 81 | Path Sum: Two Ways | |
| 82 | Path Sum: Three Ways | |
| 83 | Path Sum: Four Ways | |
| 84 | Monopoly Odds | |
| 85 | Counting Rectangles | |
| 86 | Cuboid Route | |
| 87 | Prime Power Triples | |
| 88 | Product-sum Numbers | |
| 89 | Roman Numerals | |
| 90 | Cube Digit Pairs | |
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
