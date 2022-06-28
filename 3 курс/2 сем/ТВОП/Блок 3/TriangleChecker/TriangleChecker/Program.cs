using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TriangleChecker
{
    class Program
    {
        static void Main(string[] args)
        {
            int i = 0;
            do
            {
                string firstSideInput, secondSideInput, thirdSideInput;

                do
                {
                    Console.WriteLine("Введите первую сторону: ");
                    firstSideInput = Console.ReadLine();
                    var validationError = GetSideValidationError(firstSideInput);
                    if (validationError != null)
                    {
                        Console.WriteLine(validationError);
                    }
                    else
                    {
                        break;
                    }

                } while (true);

                do
                {
                    Console.WriteLine("Введите вторую сторону: ");
                    secondSideInput = Console.ReadLine();
                    var validationError = GetSideValidationError(secondSideInput);
                    if (validationError != null)
                    {
                        Console.WriteLine(validationError);
                    }
                    else
                    {
                        break;
                    }

                } while (true);

                do
                {
                    Console.WriteLine("Введите третью сторону: ");
                    thirdSideInput = Console.ReadLine();
                    var validationError = GetSideValidationError(thirdSideInput);
                    if (validationError != null)
                    {
                        Console.WriteLine(validationError);
                    }
                    else
                    {
                        break;
                    }

                } while (true);


                Console.WriteLine(TriangleChecker.Resolve(firstSideInput, secondSideInput, thirdSideInput));

                Console.WriteLine("Чтобы продолжить введите 1. Для завершения введите любые другие символы.");
                while (!int.TryParse(Console.ReadLine(), out i))
                {
                    return;
                }
            } while (i == 1);
        }

        public static string GetSideValidationError(string firstSideInput)
        {
            int firstSideValue = 0;

            if (!string.IsNullOrWhiteSpace(firstSideInput))
            {
                if (!firstSideInput.StartsWith("0"))
                {
                    if (TriangleChecker.IsNumber(firstSideInput, out firstSideValue))
                    {
                        return null;
                    }
                    else
                    {
                        return "Введенное значение должно быть целым числом и находиться в интервале [1;2147483647]. Повторите ввод.";

                    }
                }
                else
                {
                    return "Введенное значение не должно начинаться с 0. Повторите ввод.";
                }
            }
            else
            {
                return "Сторона не была введена. Повторите ввод";
            }
        }
    }
}
