import std.stdio;
import std.datetime.stopwatch;

long reverseDigits(long number)
{
    long reversed = 0;
    
    while (number > 0)
    {
        reversed = reversed * 10 + (number % 10);
        number /= 10;
    }
    
    return reversed;
}

bool isPalindrome(long number)
{
    return number == reverseDigits(number);
}

bool isLychrel(long number)
{
    long temp = number;
    
    for (long iteration = 1; iteration <= 50; iteration++)
    {
        temp += reverseDigits(temp);
        
        if (isPalindrome(temp))
        {
            return false;
        }
    }
    
    return true;
}

void main()
{
    auto timer = StopWatch(AutoStart.yes);
    
    int lychrelTotal = 0;
    
    for (long candidate = 1; candidate <= 10_000; candidate++)
    {
        if (isLychrel(candidate))
        {
            lychrelTotal++;
        }
    }
    
    timer.stop();
        
    writefln("\nProject Euler #55\nAnswer: %s", lychrelTotal);
    writefln("Elapsed time: %s milliseconds.\n", timer.peek.total!"msecs"());    
}
