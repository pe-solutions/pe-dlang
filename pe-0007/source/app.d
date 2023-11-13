// 10001st Prime
// https://projecteuler.net/problem=7

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;

bool isPrime(int n) {
    if (n <= 1) {
        return false;
    }
    
    if (n <= 3) {
        return true;
    }
    
    if (n % 2 == 0 || n % 3 == 0) {
        return false;
    }
    
    int i = 5;
    while (i * i <= n) {
        if (n % i == 0 || n % (i + 2) == 0) {
            return false;
        }
        i += 6;
    }
    
    return true;
}

int nthprime( int n ) {
	
    if(n==1) return 2;
	
    int p, pn=1;
	
    for(p=3;pn<n;p+=2) {
        if(isPrime(p)) pn++;
    }
	
    return p-2;
}

void main() {
    StopWatch timer;
    timer.start();
    
    auto answer = nthprime(10_001);
    
    timer.stop();
    
    writefln("\nProject Euler #7\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
