// Largest palindrome product
// https://projecteuler.net/problem=4

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.conv: text;
import std.range: array, iota, retro;
import std.algorithm: cartesianProduct, filter, map, maxElement;

bool isPalindrome(int n) 
{
    auto str = n.text;
	
    return  (str == str.retro.array.text);
}

void main() {
    StopWatch timer;
    timer.start();
    
	auto R = iota(899,999+1);
	
    auto answer = cartesianProduct(R, R).map!(a => a[0] * a[1]).filter!isPalindrome.maxElement;

    timer.stop();
        
    writefln("\nProject Euler #4\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
