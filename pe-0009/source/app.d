// Special Pythagorean Triplet
// https://projecteuler.net/problem=9

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;
import std.math: abs;
import std.conv: to;

double solveEquation(double a) {
    // Function to solve
    double b = 1000 * (500 - a) / (1000 - a);

    return a * a + b * b - (1000 - a - b) * (1000 - a - b);
}

double solveDerivative(double a) {
    // Derivative of the function to solve
    double b = 1000 * (500 - a) / (1000 - a);

    double da = 2 * a - 2 * (1000 - a - b);
    double db = 2 * b - 2 * (1000 - a - b);
    
    return (a * da + b * db);
}

double newtonRaphson(double initialGuess, int maxIterations = 100, double tolerance = 1e-6) {
    // Numerical solver
    
    double x = initialGuess;

    for (int i = 0; i < maxIterations; ++i) {
        double fx = solveEquation(x);
        double dfx = solveDerivative(x);

        double deltaX = fx / dfx;

        x -= deltaX;

        if (abs(deltaX) < tolerance) {
            return x;
        }
    }
    
    return double.nan;
}

void main() {
    StopWatch timer;
    timer.start();
    
    // Starting with an initial guess of 200
	long a = newtonRaphson(200).to!long;

    long b = 1000 * (500 - a) / (1000 - a);
    long c = 1000 - a - b;

	auto answer = a*b*c;

    timer.stop();
    
    writefln("\nProject Euler #9\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
