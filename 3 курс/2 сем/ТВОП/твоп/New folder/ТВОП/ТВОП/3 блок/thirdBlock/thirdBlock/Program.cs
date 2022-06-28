using System;


namespace thirdBlock
{
    public class Program
    {

        public static void Main(string[] args)
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
                    Console.WriteLine("Треугольника с такими сторонами не существует");
                }
            }
            else
            {
                Console.WriteLine("Слишком большие значения сторон");
            }

            Console.ReadLine();
        }

    }

    public class Triangle
    {
        public int A, B, C;
        private bool flag;

       public int InputSide(string side)
       {
            int d = 0;
            do
            {
                try
                {
                    flag = true;
                    Console.WriteLine("Ведите " + side + " сторону");
                    d = int.Parse(Console.ReadLine());
                    return d;
                }
                catch (Exception)
                {
                    Console.WriteLine("Неверный ввод! Повторите");
                    flag = false;
                }

            } while (!flag);
          
           return d;
       }

        public bool IsExist(int a, int b, int c)
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

        public bool IsOwerflow(int a, int b, int c)
        {
            try
            {
                checked
                {
                    int temp = a + b;
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

        public void RecogniseTriangle(int a, int b, int c)
        {
            if ((a == b) && (b == c))
            {
                Console.WriteLine("Равносторонний треугольник");
            }
            else
            {
                if ((a == b)  || (b == c) || (a == c))
                {
                    Console.WriteLine("Равнобедренный треугольник");
                }
                else
                {
                    Console.WriteLine("Разносторонний треугольник");
                }
            }

        }

    }

}



        

