using System;


namespace thirdBlock

{ 
        public class Program
        {

        public static void Main(string[] args)
        {
            int i = 0;
            do
            {
                var triangle = new Triangle();
                triangle.A = triangle.InputSide("1");
                triangle.B = triangle.InputSide("2");
                triangle.C = triangle.InputSide("3");
                if (!(triangle.IsOwerflow(triangle.A, triangle.B, triangle.C)))
                {
                    if (triangle.IsExist(triangle.A, triangle.B, triangle.C))
                    {
                        triangle.RecogniseTriangle(triangle.A, triangle.B, triangle.C);
                    }
                    else
                    {
                        Console.WriteLine("Треугольника с введенными сторонами не существует. Сумма любых двух сторон должна быть больше третьей стороны.");
                    }
                }
                else
                {
                    Console.WriteLine("Треугольника с введенными сторонами не существует. Сумма любых двух сторон должна быть больше третьей стороны.");
                }

                Console.ReadLine();
                Console.WriteLine("Чтобы продолжить нажмите 1. Для завершения нажмите любую другую клавишу.");
                while (!int.TryParse(Console.ReadLine(), out i))
                {
                    return;
                }                
            } while (i == 1);
        }

        }

        public class Triangle
        {
            public long A, B, C;
            private bool flag;

            public long InputSide(string side)
            {
            long d = 0;
                do
                {
                    try
                    {
                        flag = true;
                        Console.WriteLine("Введите " + side + " сторону");
                        string s = Console.ReadLine();
                        d = (s[0] == '0' || s[0] == ' ') ? 0 : long.Parse(s);
                        if ((d <= 0) || ( d > 2147483647))
                        {
                            Console.WriteLine(value: "Ошибка! Число должно задаваться целым и положительным в диапазоне 1..2147483647.");

                            flag = false;
                        }
                        else
                        {
                            return d;
                        }

                    }
                    catch (Exception)
                    {
                        Console.WriteLine(value: "Ошибка! Число должно задаваться целым и положительным в диапазоне 1..2147483647.");

                        flag = false;
                    }

                } while (!flag);

                return d;
            }

            public bool IsExist(long a, long b, long c)
            {
                if ((a > 0) && (b > 0) && (c > 0))
                {
                    if ((a + b > c) && (a + c > b) && (b + c > a))
                    {
                        return true;
                    }
                }
              
                return false;
            }

            public bool IsOwerflow(long a, long b, long c)
            {
                try
                {
                    checked
                    {
                        long temp = a + b;
                        temp = a + c;
                        temp = c + b;
                    }
              
                    return false;
                }
                catch (OverflowException)
                {
                    return true;
                }
            }

            public void RecogniseTriangle(long a, long b, long c)
            {
                if ((a == b) && (b == c))
                {
                    Console.Write("Равносторонний треугольник");
                }
                else
                {
                    if ((a == b) || (b == c) || (a == c))
                    {
                        Console.Write("Равнобедренный треугольник");
                    }
                    else
                    {
                        Console.Write("Неравносторонний треугольник");
                    }
                }

            }


        }
  
}






