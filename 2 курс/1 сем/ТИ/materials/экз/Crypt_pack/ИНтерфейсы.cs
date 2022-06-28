using interfacee;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace interfacee
{
    public interface ITringleInt
    {
        double ThirdLine();
    }
    public interface math
    {
        double area();
        double volume();

    }
    class figure : math
    {
        public virtual double area()
        {
            return 0;
        }
        public virtual double volume()
        {
            return 0;
        }
    }
    class point : figure
    {
        double x, y;
        override public double area()
        {
            Console.WriteLine("Нельзя найти площадь точки ");
            return 0;

        }
        public point(double x = 1, double y = 1)
        {
            this.x = x; this.y = y;
        }
        override public double volume()
        {
            Console.WriteLine("Нельзя найти объем точки ");
            return 0;

        }
    }
    class line : figure
    {
        double x, y;
        double x2, y2;
        override public double area()
        {
            Console.WriteLine("Нельзя найти площадь линии ");
            return 0;

        }
        public line(double x = 1, double y = 1, double x2 = 2, double y2 = 2)
        {
            this.x = x; this.y = y;
            this.x2 = x2; this.y2 = y2;
        }
        override public double volume()
        {
            Console.WriteLine("Нельзя найти объем линии  ");
            return 0;

        }
    }
    class circle : figure
    {
        double x, y, R;

        override public double area()
        {
            Console.WriteLine("Площадь круга = ");
            double S = Math.PI * R * R;
            Console.Write(S);
            return S;

        }
        public circle(double x = 1, double y = 1, double R = 1)
        {
            this.x = x; this.y = y;
            this.R = R;
        }
        override public double volume()
        {
            Console.WriteLine("Нельзя найти объем круга  ");
            return 0;

        }
    }
    class cilinder : figure
    {
        double h, R;
        public cilinder(double h = 1, double R = 1)
        {
            this.h = h;
            this.R = R;
        }
        public override double volume()
        {
            Console.WriteLine("Объём цилиндра = ");
            double V = Math.PI * Math.Pow(R, 2) * h;
            Console.Write(V);
            return V;
        }
        public override double area()
        {
            Console.WriteLine("Площадь цилиндра = ");
            double S = 2 * Math.PI * Math.Pow(R, 2) + 2 * Math.PI * R * h;
            Console.Write(S);
            return S;
        }


    }


    public class Triangle : ITringleInt
    {
        private double A;
        private double B;
        public Triangle(double a, double b)
        {
            A = a;
            B = b;
        }
        public double ThirdLine()
        {
            return Math.Sqrt(Math.Pow(A, 2) + Math.Pow(B, 2));
        }
    }
}




class Program
{
    static void Main(string[] args)
    {
        
       
        double a, b;
        Console.Write("Введите A:");
        a = double.Parse(Console.ReadLine());
        Console.Write("Введите B:");
        b = double.Parse(Console.ReadLine());
        Triangle triang = new Triangle(a, b);
        Console.WriteLine(triang.ThirdLine());
      
        circle cire = new circle();
        Console.WriteLine(cire.volume());
        Console.ReadLine();
    }
}

