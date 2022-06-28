using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using thirdBlock;

namespace thirdBlockTests
{
    [TestClass()]
    public class ProgramTests
    {
        [TestMethod()]
        public void IsExist_When_OneOfSisesZero_Should_False()
        {
            char a = ' ';
            int b = 4;
            int c = 5;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false,actual);
        }

        [TestMethod()]
        public void IsExist_When_OneOfSises_Und_Should_False()
        {
            int a = 4;
            char b = ' ';
            int c = 5;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_OneOfSisesUnd_Should_False()
        {
            int b = 4;
            int a = 5;
            char c = ' ';

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_AllOfSisesUnd_Should_False()
        {
            char a = ' ';
            char b = ' ';
            char c = ' ';

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(true, actual);
        }

        [TestMethod()]
        public void IsExist_When_AllOfSisesChar_Should_False()
        {
            char a = 'щ';
            char b = '%';
            char c = 'G';

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_One_OfSisesChar_Should_False()
        {
            char a = 'щ';
            int b = 1;
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_Two_OfSisesChar_Should_False()
        {
            int a = 1;
            char b = '%';
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_Three_OfSisesChar_Should_False()
        {
            int a = 1;
            int b = 1;
            char c = 'G';

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_AllOfSisesZero_Should_False()
        {
            int a = 0;
            int b = 0;
            int c = 0;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_OneOfSises_Zero_Should_False()
        {
            int a = 0;
            int b = 1;
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_TwoOfSises_Zero_Should_False()
        {
            int a = 1;
            int b = 0;
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_ThreeOfSises_Zero_Should_False()
        {
            int a = 1;
            int b = 1;
            int c = 0;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_One_OfSisesNegative_Should_True()
        {
            int a = -1;
            int b = 2;
            int c = 3;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_Two_OfSisesNegative_Should_True()
        {
            int a = 1;
            int b = -2;
            int c = 3;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_Three_OfSisesNegative_Should_True()
        {
            int a = 1;
            int b = 2;
            int c = -3;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_AllOfSisesNegative_Should_True()
        {
            int a = -3;
            int b = -4;
            int c = -5;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_TriangleNotExist_Should_False()
        {
            int a = 1;
            int b = 1;
            int c = 2;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_When_OneOfSisesMaxInt_Should()
        {
            long a = 2147483648;
            long b = 1;
            long c = 2;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_When_TwoOfSisesMaxInt_Should()
        {
            long a = 1;
            long b = 2147483648;
            long c = 2;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_WhenTreeOfSisesMaxInt_Should()
        {
            long a = 1;
            long b = 2;
            long c = 2147483648;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_When_All_OfSisesMaxInt_Should()
        {
            long a = 2147483648;
            long b = 2147483648;
            long c = 2147483648;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_When_NotOwerflow_Should_False()
        {
            int a = 1;
            int b = 1;
            int c = 2;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_When_Two_NotOwerflow_Should_False()
        {
            int a = 1;
            int b = 2;
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_When_Three_NotOwerflow_Should_False()
        {
            int a = 2;
            int b = 1;
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_SunOfTwo_Less_then_One()
        {
            int a = 1;
            int b = 1;
            int c = 3;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_SunOfTwo_Less_then_Two()
        {
            int a = 3;
            int b = 1;
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_SunOfTwo_Less_then_Three()
        {
            int a = 1;
            int b = 3;
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_Fractional_number_One()
        {
            double a = 1.1;
            int b = 1;
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow((int) a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_Fractional_number_Two()
        {
            int a = 1;
            double b = 1.1;
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, (int)b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_Fractional_number_Three()
        {
            int a = 1;
            int b = 1;
            double c = 1.1;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, (int)c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsOwerflow_Fractional_number_All()
        {
            double a = 1.1;
            double b = 1.1;
            double c = 1.1;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow((int)a, (int)b, (int)c);
            Assert.AreEqual(false, actual);
        }

   
        [TestMethod()]
        public void IsExist_Correct_Equilateral_Boundary_Values_True()
        {
            int a = 1;
            int b = 1;
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(true, actual);
        }

        [TestMethod()]
        public void IsExist_Correct_Equilateral_Max_Boundary_Values_True()
        {
            int a = 2147483647;
            int b = 2147483647;
            int c = 2147483647;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(true, actual);
        }
        [TestMethod()]
        public void IsExist_Correct_Isosceles_Max_Boundary_Values_True()
        {
            int a = 1;
            int b = 2;
            int c = 2;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(true, actual);
        }

        [TestMethod()]
        public void IsExist_Correct_Isosceles_Boundary_Values_True()
        {
            int a = 2;
            int b = 2;
            int c = 1;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(true, actual);
        }

        [TestMethod()]
        public void IsExist_Correct_Isosceles_MaxBoundary_Values_True()
        {
            int a = 2;
            int b = 1;
            int c = 2;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(true, actual);
        }

        [TestMethod()]
        public void IsExist_Correct_Inequilateral_MaxBoundary_Values_True()
        {
            int a = 2;
            int b = 3;
            int c = 4;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(true, actual);
        }

        [TestMethod()]
        public void IsExist_Correct_Inequilateral_Max_Boundary_Values_True()
        {
            int a = 2147483647;
            int b = 2147483646;
            int c = 2147483645;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(true, actual);
        }
    }
}