# Problems 51–100

[← Index](SOLUTIONS.md)

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
| [67](../pe-0067/source/app.d) | Maximum Path Sum II | Same bottom-up DP as #18; CTFE-parsed 100-row triangle file |
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
