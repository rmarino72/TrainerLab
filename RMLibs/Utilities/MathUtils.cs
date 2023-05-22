using System;

namespace RMLibs.Utilities;

public class MathUtils
{
    /// <summary>
    ///     Returns a random int number between 0 and max - 1
    /// </summary>
    /// <param name="max">the upper range</param>
    /// <returns>the random int number</returns>
    public static int RandomInteger(int max)
    {
        return new Random().Next(0, max);
    }
}