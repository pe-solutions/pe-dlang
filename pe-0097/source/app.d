// Large Non-Mersenne Prime
// https://projecteuler.net/problem=97

import std.bigint : BigInt;
import euler.common : runSolution;

private long large_non_mersenne_prime(BigInt base, BigInt exponent, BigInt coeff, BigInt modulus) {
    import std.bigint : powmod;
    return powmod((coeff * powmod(base, exponent, modulus) + 1), 1.BigInt, modulus).toLong;
}

auto solve() {
    import std.bigint : BigInt;
    return large_non_mersenne_prime(2.BigInt, 7_830_457.BigInt, 28_433.BigInt, 10.BigInt ^^ 10);
}

void main() { runSolution!(solve)(97); }
