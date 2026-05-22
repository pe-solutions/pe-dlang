// Roman Numerals
// https://projecteuler.net/problem=89

import euler.common : runSolution;

private int parseRoman(string s) pure nothrow @nogc {
    static immutable int[256] val = () {
        int[256] v;
        v['I'] = 1; v['V'] = 5; v['X'] = 10; v['L'] = 50;
        v['C'] = 100; v['D'] = 500; v['M'] = 1000;
        return v;
    }();
    int result = 0;
    foreach (i; 0 .. s.length) {
        immutable int cur = val[s[i]];
        immutable int nxt = (i + 1 < s.length) ? val[s[i + 1]] : 0;
        result += (cur < nxt) ? -cur : cur;
    }
    return result;
}

private string toMinimalRoman(int n) pure {
    import std.array : appender;
    static immutable int[]    values  = [1000,900,500,400,100, 90, 50, 40, 10,  9,  5,  4,  1];
    static immutable string[] symbols = ["M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"];
    auto buf = appender!string;
    foreach (i, v; values) {
        while (n >= v) { buf.put(symbols[i]); n -= v; }
    }
    return buf.data;
}

auto solve() {
    import std.algorithm : map, sum;
    import std.string : splitLines, strip;
    enum string raw = import("data/roman.txt");
    return raw.splitLines
              .map!(line => line.strip)
              .map!(line => cast(int) line.length - cast(int) toMinimalRoman(parseRoman(line)).length)
              .sum;
}

void main() { runSolution!(solve)(89); }
