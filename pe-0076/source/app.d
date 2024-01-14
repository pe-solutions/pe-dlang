// Counting Summations
// https://projecteuler.net/problem=76

import std.stdio;
import std.datetime.stopwatch: StopWatch;

long numbpart(long n)
{
    long[] partitionTable = new long[n + 1];
	const long[] initialVector = [1, 1, 2, 3];

    void initializePartitionTable(const long[] initialValue)
    {
        foreach (i, value; initialValue)
            partitionTable[i] = value;
    }

    long calculatePartition(long number)
    {
        long sum = 0;
        long k = 1;
        int sign = 1;

        do
        {
            long pentagonal1 = k * (3 * k - 1) / 2;
            long pentagonal2 = k * (3 * k + 1) / 2;

            if (pentagonal1 > number)
                break;

            if (number - pentagonal1 >= 0)
                sum += partitionTable[number - pentagonal1] * sign;

            if (number - pentagonal2 >= 0)
                sum += partitionTable[number - pentagonal2] * sign;

            k++;
            sign = -sign;
        } while (true);

        return sum;
    }
 
	initializePartitionTable(initialVector);

    long currentNumber = initialVector.length;
    do
    {
        partitionTable[currentNumber] = calculatePartition(currentNumber);

        if (currentNumber == n)
        {
            return partitionTable[currentNumber];
        }

        currentNumber++;
    } while (true);
}

void main()
{
    StopWatch timer;
    timer.start();

    auto answer = numbpart(100) - 1;

    timer.stop();

    writefln("\nProject Euler #76\nAnswer: %s", answer);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());
}
