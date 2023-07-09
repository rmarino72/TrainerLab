using System;

namespace TLServer.BL;

public class GymnFormulas
{
    public static float Bmi(float weight, float height)
    {
        return (float)Math.Round(weight / (height * height), 2);
    }

    public static double BodyDensityWoman(double plicometrySum, int age)
    {
        return 1.097 - (0.00046971 * plicometrySum) + 
            (0.00000056 * plicometrySum * plicometrySum) - 
            (0.00012828 * age);
    }
    
    public static double BodyDensityMan(double plicometrySum, int age)
    {
        return 1.112 - (0.00043499 * plicometrySum) + 
               (0.00000055 * plicometrySum * plicometrySum) - 
               (0.00028826 * age);
    }

    public static double FatPercentage(double bodyDensity)
    {
        return (495/bodyDensity)-450;
    }
}