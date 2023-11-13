// 10001st Prime
// https://projecteuler.net/problem=7

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;

int isPrime( int p ) {
    int i;
	
    if(p==2) return 1;
	
    if(!(p%2)) return 0;
	
    for(i=3; i*i<=p; i+=2) {
       if(!(p%i)) return 0;
    }
	
    return 1;
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
