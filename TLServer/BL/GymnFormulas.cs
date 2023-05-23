using System;

namespace TLServer.BL;

public class GymnFormulas
{
    public static float Bmi(float weight, float height)
    {
        return (float)Math.Round(weight / (height * height), 2);
    }
}