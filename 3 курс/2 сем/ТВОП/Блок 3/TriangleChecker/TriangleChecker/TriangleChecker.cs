using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TriangleChecker
{
    public class TriangleChecker
    {
        private static int firstSide, secondSide, thirdSide;

        public static string Resolve(string firstSideInput, string secondSideInput, string thirdSideInput)
        {
            if (!(string.IsNullOrWhiteSpace(firstSideInput) || string.IsNullOrWhiteSpace(secondSideInput) ||
                string.IsNullOrWhiteSpace(thirdSideInput)))
            {
                if (!(firstSideInput.StartsWith("0") || secondSideInput.StartsWith("0") ||
                          thirdSideInput.StartsWith("0")))
                { 
                    if (IsNumber(firstSideInput, out firstSide)
                        && IsNumber(secondSideInput, out secondSide)
                        && IsNumber(thirdSideInput, out thirdSide))
                    {
                        if (IsTriangle(firstSide, secondSide, thirdSide))
                        {
                            if (firstSide == secondSide && firstSide == thirdSide)
                            {
                                return "Треугольник равносторонний.";
                            }
                            else if (firstSide == secondSide || firstSide == thirdSide || secondSide == thirdSide)
                            {
                                return "Треугольник равнобедренный.";
                            }
                            else
                            {
                                return "Треугольник неравносторонний.";
                            }
                        }
                        else
                        {
                            return "Из данных сторон нельзя составить треугольник." +
                                                 " Сумма длин двух любых сторон треугольника не должна быть больше третьей стороны. Повторите ввод.";
                        }
                    }
                    else
                    {
                        return "Введённые значения должны быть целыми числами и находиться в интервале [1;2147483647]. Повторите ввод.";

                    }
                }
                else
                {
                    return "Введённые значения должны быть целыми числами и находиться в интервале [1;2147483647]. Повторите ввод.";
                }
            }
            else
            {
                return "Введённые значения должны быть целыми числами и находиться в интервале [1;2147483647]. Повторите ввод.";
            }
        }

        public static bool IsNumber(string textValue, out int value)
        {
            return int.TryParse(textValue, out value) && value > 0 && value <= 2147483647;
        }

        public static bool IsTriangle(int firstSide, int secondSide, int thirdSide)
        {
            long firstSideLong = firstSide;
            long secondSideLong = secondSide;
            long thirdSideLong = thirdSide;

            return (firstSideLong + secondSideLong > thirdSideLong) && 
                   (firstSideLong + thirdSideLong > secondSideLong) && 
                   (thirdSideLong + secondSideLong > firstSideLong);
        }
    }
}
