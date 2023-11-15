// Integer Right Triangles
// https://projecteuler.net/problem=39

import std.stdio : writefln;
import std.datetime.stopwatch: StopWatch;

void main()
{
    StopWatch timer;
    timer.start();
	
	int maxPerimeter = 0;
    int maxCount = 0;

    foreach (p; 12 .. 1001)
    {
        int count = 0;

        foreach (b; 2 .. p / 2)
        {
            foreach (a; 1 .. b)
            {
                int c = p - (a + b);
				// 
                if (a * a + b * b == c * c && c > b && c > a)
                {
                    count++;
                }
            }
        }

        if (count > maxCount)
        {
            maxCount = count;
            maxPerimeter = p;
        }
    }

	auto answer = maxPerimeter;

	timer.stop();

	writefln("\nProject Euler #39\nAnswer: %s", answer);
	writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
