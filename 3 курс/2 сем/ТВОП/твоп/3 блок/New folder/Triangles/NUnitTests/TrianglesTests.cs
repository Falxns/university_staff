using System;
using System.Collections.Generic;
using NUnit.Framework;

namespace Triangles.Tests
{
    [TestFixture]
    public class TrianglesTests
    {
        Form1 appInstance;
        [SetUp]
        public void Init()
        {
            appInstance = new Form1();
        }

        private static IEnumerable<TestCaseData> DataCases
        {
            get
            {
                yield return new TestCaseData(null,"3", "3").Returns(false);
                yield return new TestCaseData("3", null, "3").Returns(false);
                yield return new TestCaseData("3", "3", null).Returns(false);
                yield return new TestCaseData("3", null, null).Returns(false);
                yield return new TestCaseData(null, "3", null).Returns(false);
                yield return new TestCaseData(null, null, "3").Returns(false);

            }
        }
        [TestCaseSource(nameof(DataCases))]
        public bool Null_StringIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("unvalid triangle");
            return appInstance.Valid_Triangle(firstSide, secondSide, thirdSide);
        }
        private static IEnumerable<TestCaseData> DataCases2
        {
            get
            {
                yield return new TestCaseData("aaaaa", "3", "3").Returns(false);
                yield return new TestCaseData("3", "aaaaa", "3").Returns(false);
                yield return new TestCaseData("3", "3", "aaaaa").Returns(false);
                yield return new TestCaseData("aaaaa", "aaaaa", "aaaaa").Returns(false);
                yield return new TestCaseData("3", "aaaaa", "aaaaa").Returns(false);
                yield return new TestCaseData("aaaaa", "3", "aaaaa").Returns(false);
                yield return new TestCaseData("aaaaa", "ааааа", "3").Returns(false);
            }
        }

        [TestCaseSource(nameof(DataCases2))]
        public bool Symbol_StringIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("unvalid parameter");
            return appInstance.Valid_Triangle(firstSide, secondSide, thirdSide);
        }

        private static IEnumerable<TestCaseData> DataCases3
        {
            get
            {
                yield return new TestCaseData("0", "2", "2").Returns(false);
                yield return new TestCaseData("2", "0", "2").Returns(false);
                yield return new TestCaseData("2", "2", "0").Returns(false);
                yield return new TestCaseData("0", "0", "0").Returns(false);
                yield return new TestCaseData("2", "0", "0").Returns(false);
                yield return new TestCaseData("0", "2", "0").Returns(false);
                yield return new TestCaseData("0", "0", "2").Returns(false);
            }
        }
        [TestCaseSource(nameof(DataCases3))]
        public bool Zeros_StringIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("unvalid parameter");
            return appInstance.Valid_Triangle(firstSide, secondSide, thirdSide);
        }
        private static IEnumerable<TestCaseData> DataCases4
        {
            get
            {
                yield return new TestCaseData("1", "1", "3").Returns(false);
                yield return new TestCaseData("1", "3", "1").Returns(false);
                yield return new TestCaseData("3", "1", "1").Returns(false);
            }
        }
        [TestCaseSource(nameof(DataCases4))]
        public bool UnValidParameters_StringIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("unvalid parameter");
            return appInstance.Valid_Triangle(firstSide, secondSide, thirdSide);
        }
        private static IEnumerable<TestCaseData> DataCases5
        {
            get
            {
                yield return new TestCaseData("1", "2", "3").Returns(false);
                yield return new TestCaseData("2", "1", "3").Returns(false);
                yield return new TestCaseData("3", "2", "1").Returns(false);
                yield return new TestCaseData("3", "1", "2").Returns(false);
                yield return new TestCaseData("2", "3", "1").Returns(false);
                yield return new TestCaseData("1", "3", "2").Returns(false);
                yield return new TestCaseData("1", "1", "2").Returns(false);
                yield return new TestCaseData("2", "1", "1").Returns(false);
                yield return new TestCaseData("1", "2", "1").Returns(false);
            }
        }
        [TestCaseSource(nameof(DataCases5))]
        public bool UnValidParameterEquality_StringIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("unvalid parameter");
            return appInstance.Valid_Triangle(firstSide, secondSide, thirdSide);
        }
        private static IEnumerable<TestCaseData> DataCases6
        {
            get
            {
                yield return new TestCaseData("1", "1", "1").Returns("Равносторонний");
                yield return new TestCaseData("100", "100", "100").Returns("Равносторонний");
                yield return new TestCaseData("999", "999", "999").Returns("Равносторонний");
                yield return new TestCaseData("9999", "9999", "9999").Returns("Равносторонний");
                yield return new TestCaseData("99999", "99999", "99999").Returns("Равносторонний");
                yield return new TestCaseData("999999", "999999", "999999").Returns("Равносторонний");
                yield return new TestCaseData("66666", "66666", "66666").Returns("Равносторонний");
                yield return new TestCaseData("99999999", "99999999", "99999999").Returns("Равносторонний");
            }
        }
        [TestCaseSource(nameof(DataCases6))]
        public string Equal_TriangleIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("equal triangle is passed");
            return appInstance.Get_Triangle_Type(firstSide, secondSide, thirdSide);
        }

        private static IEnumerable<TestCaseData> DataCases7
        {
            get
            {
                yield return new TestCaseData("1", "2", "2").Returns("Равнобедреный");
                yield return new TestCaseData("2", "1", "2").Returns("Равнобедреный");
                yield return new TestCaseData("2", "2", "1").Returns("Равнобедреный");
                yield return new TestCaseData("55555", "55555", "66666").Returns("Равнобедреный");
                yield return new TestCaseData("55555", "66666", "55555").Returns("Равнобедреный");
                yield return new TestCaseData("66666", "55555", "55555").Returns("Равнобедреный");
                yield return new TestCaseData("99999998", "99999999", "99999999").Returns("Равнобедреный");
                yield return new TestCaseData("99999999", "99999998", "99999999").Returns("Равнобедреный");
                yield return new TestCaseData("99999999", "99999999", "99999998").Returns("Равнобедреный");
            }
        }
        [TestCaseSource(nameof(DataCases7))]
        public string Isosceles_TriangleIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("isosceles triangle is passed");
            return appInstance.Get_Triangle_Type(firstSide, secondSide, thirdSide);
        }

        private static IEnumerable<TestCaseData> DataCases8
        {
            get
            {
                yield return new TestCaseData("2", "3", "4").Returns("Неравносторонний");
                yield return new TestCaseData("4", "2", "3").Returns("Неравносторонний");
                yield return new TestCaseData("3", "4", "2").Returns("Неравносторонний");
                yield return new TestCaseData("2", "4", "3").Returns("Неравносторонний");
                yield return new TestCaseData("4", "3", "2").Returns("Неравносторонний");
                yield return new TestCaseData("3", "2", "4").Returns("Неравносторонний");

                yield return new TestCaseData("11112", "55555", "66666").Returns("Неравносторонний");
                yield return new TestCaseData("11112", "66666", "55555").Returns("Неравносторонний");
                yield return new TestCaseData("55555", "11112", "66666").Returns("Неравносторонний");
                yield return new TestCaseData("55555", "66666", "11112").Returns("Неравносторонний");
                yield return new TestCaseData("66666", "55555", "11112").Returns("Неравносторонний");
                yield return new TestCaseData("66666", "11112", "55555").Returns("Неравносторонний");

                yield return new TestCaseData("99999997", "99999998", "99999999").Returns("Неравносторонний");
                yield return new TestCaseData("99999997", "99999999", "99999998").Returns("Неравносторонний");
                yield return new TestCaseData("99999998", "99999997", "99999999").Returns("Неравносторонний");
                yield return new TestCaseData("99999998", "99999999", "99999997").Returns("Неравносторонний");
                yield return new TestCaseData("99999999", "99999997", "99999998").Returns("Неравносторонний");
                yield return new TestCaseData("99999999", "99999998", "99999997").Returns("Неравносторонний");

            }
        }
        [TestCaseSource(nameof(DataCases8))]
        public string Scalene_TriangleIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("scalene triangle is passed");
            return appInstance.Get_Triangle_Type(firstSide, secondSide, thirdSide);
        }

        private static IEnumerable<TestCaseData> DataCases9
        {
            get
            {
                yield return new TestCaseData("1000000000", "999999999", "999999999").Returns(false);
                yield return new TestCaseData("999999999", "1000000000", "999999999").Returns(false);
                yield return new TestCaseData("999999999",  "999999999", "1000000000").Returns(false);
            }
        }
        [TestCaseSource(nameof(DataCases9))]
        public bool OverFlow_StringIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("too big of a string is passed");
            return appInstance.Valid_Triangle(firstSide, secondSide, thirdSide);
        }

        private static IEnumerable<TestCaseData> DataCases10
        {
            get
            {
                yield return new TestCaseData("1,1", "1", "1").Returns(false);
                yield return new TestCaseData("1", "1,1", "1").Returns(false);
                yield return new TestCaseData("1", "1", "1,1").Returns(false);

                yield return new TestCaseData("1.1", "1", "1").Returns(false);
                yield return new TestCaseData("1", "1.1", "1").Returns(false);
                yield return new TestCaseData("1", "1", "1.1").Returns(false);
            }
        }
        [TestCaseSource(nameof(DataCases10))]
        public bool RealNumbers_StringIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("too big of a string is passed");
            return appInstance.Valid_Triangle(firstSide, secondSide, thirdSide);
        }

        private static IEnumerable<TestCaseData> DataCases11
        {
            get
            {
                yield return new TestCaseData("1+2", "1", "1").Returns(false);
                yield return new TestCaseData("1", "1+2", "1").Returns(false);
                yield return new TestCaseData("1", "1", "1+2").Returns(false);
                yield return new TestCaseData("1+2", "1+2", "1+2").Returns(false);

                yield return new TestCaseData("2-1", "1", "1").Returns(false);
                yield return new TestCaseData("1", "2-1", "1").Returns(false);
                yield return new TestCaseData("1", "1", "2-1").Returns(false);
                yield return new TestCaseData("2-1", "2-1", "2-1").Returns(false);

                yield return new TestCaseData("2/1", "1", "1").Returns(false);
                yield return new TestCaseData("1", "2/1", "1").Returns(false);
                yield return new TestCaseData("1", "1", "2/1").Returns(false);
                yield return new TestCaseData("2/1", "2/1", "2/1").Returns(false);

                yield return new TestCaseData("1*2", "1", "1").Returns(false);
                yield return new TestCaseData("1", "1*2", "1").Returns(false);
                yield return new TestCaseData("1", "1", "2*1").Returns(false);
                yield return new TestCaseData("1*2", "1*2", "1*2").Returns(false);

                yield return new TestCaseData("(1+2)", "1", "1").Returns(false);
                yield return new TestCaseData("1", "(1+2)", "1").Returns(false);
                yield return new TestCaseData("1", "1", "(1+2)").Returns(false);
                yield return new TestCaseData("(1+2)", "(1+2)", "(1+2)").Returns(false);
            }
        }
        [TestCaseSource(nameof(DataCases11))]
        public bool Expression_StringIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("too big of a string is passed");
            return appInstance.Valid_Triangle(firstSide, secondSide, thirdSide);
        }


        private static IEnumerable<TestCaseData> DataCases12
        {
            get
            {
                yield return new TestCaseData("1 2", "1", "1").Returns(false);
                yield return new TestCaseData("1", "1 2", "1").Returns(false);
                yield return new TestCaseData("1", "1", "1 2").Returns(false);

                yield return new TestCaseData("1 2", "1 2", "1 2").Returns(false);
            }
        }
        [TestCaseSource(nameof(DataCases12))]
        public bool Space_StringIsPassed(string firstSide, string secondSide, string thirdSide)
        {
            Console.WriteLine("too big of a string is passed");
            return appInstance.Valid_Triangle(firstSide, secondSide, thirdSide);
        }

    }
}
