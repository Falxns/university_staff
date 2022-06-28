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
            int a = 0;
            int b = 4;
            int c = 5;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false,actual);
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
        public void IsExist_When_OneOfSisesNegative_Should_False()
        {
            int a = 0;
            int b = -6;
            int c = 5;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(false, actual);
        }

        [TestMethod()]
        public void IsExist_When_AllOfSisesCorrect_Should_True()
        {
            int a = 3;
            int b = 4;
            int c = 5;

            var triangle = new Triangle();
            bool actual = triangle.IsExist(a, b, c);
            Assert.AreEqual(true, actual);
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
        public void IsOwerflow_When_OneOfSisesMaxInt_Should_True()
        {
            int a = Int32.MaxValue;
            int b = 4;
            int c = 5;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(true, actual);
        }

        [TestMethod()]
        public void IsOwerflow_When_TwoOfSisesMaxInt_Should_True()
        {
            int a = Int32.MaxValue/2 + 1;
            int b = Int32.MaxValue/2 + 1;
            int c = 5;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(true, actual);
        }

        [TestMethod()]
        public void IsOwerflow_When_NotOwerflow_Should_False()
        {
            int a = 3;
            int b = 4;
            int c = 5;

            var triangle = new Triangle();
            bool actual = triangle.IsOwerflow(a, b, c);
            Assert.AreEqual(false, actual);
        }

        
    }
}