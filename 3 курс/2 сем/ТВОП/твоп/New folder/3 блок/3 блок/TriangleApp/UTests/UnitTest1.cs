
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TriangleApp;
using System.Windows.Forms;

namespace UTests
{
    [TestClass]
    public class UnitTest1
    {
        MainForm _use;


        [TestInitialize]
        public void Init()
        {
            _use = new MainForm();
        }
        [TestMethod]
        public void check_empty_textBox()
        {
            var res = _use.IsTextBoxEmpty("");
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void addZeroes()
        {
            var res = _use.isTriangle(0, 0, 0);
            Assert.AreEqual(false, res);
        }

        [TestMethod]
        public void addZeroes_a()
        {
            var res = _use.isTriangle(0, 2, 3);
            Assert.AreEqual(false, res);
        }

        [TestMethod]
        public void addZeroes_b()
        {
            var res = _use.isTriangle(2, 0, 3);
            Assert.AreEqual(false, res);
        }

        [TestMethod]
        public void addZeroes_c()
        {
            var res = _use.isTriangle(2, 3, 0);
            Assert.AreEqual(false, res);
        }

        [TestMethod]
        public void check_is_triangle_3_3_3()
        {
            var res = _use.isTriangle(3,3,3);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void check_is_triangle_1_2_2()
        {
            var res = _use.isTriangle(1,2,2);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void check_is_not_versatile_triangle_2_2_2()
        {
            var res = _use.TypeTriangle(2, 2, 2);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void check_is_versatile_triangle_3_4_5()
        {
            var res = _use.TypeTriangle(3, 4, 5);
            Assert.AreEqual(false, res);
        }
        [TestMethod]
        public void check_is_not_versatile_triangle_4_5_5()
        {
            var res = _use.TypeTriangle(4, 5, 5);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void check_is_not_equals_triangle_4_4_5()
        {
            var res = _use.isTriangleEquals(4, 4, 5);
            Assert.AreEqual(false, res);
        }
        [TestMethod]
        public void check_is_equals_triangle_4_4_4()
        {
            var res = _use.isTriangleEquals(4, 4, 4);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void check_is_not_equals_triangle_123_123_122()
        {
            var res = _use.isTriangleEquals(123, 123, 122);
            Assert.AreEqual(false, res);
        }
        [TestMethod]
        public void check_is_versatile_triangle_4_5_6()
        {
            var res = _use.TypeTriangle(4, 5, 6);
            Assert.AreEqual(false, res);
        }
        [TestMethod]
        public void check_is_not_triangle_5_2_2()
        {
            var res = _use.isTriangle(5, 2, 2);
            Assert.AreEqual(false, res);
        }

        [TestMethod]
        public void equals_triangle_1_1_1()
        {
            var res = _use.isTriangleEquals(1, 1, 1);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void equals_triangle_66666_66666_66666()
        {
            var res = _use.isTriangleEquals(66666, 66666, 66666);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void equals_triangle_99999999_99999999_99999999()
        {
            var res = _use.isTriangleEquals(99999999, 99999999, 99999999);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void check_is_isosceles_triangle_1_2_2()
        {
            var res = _use.TypeTriangle(1, 2, 2);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void check_is_isosceles_triangle_2_1_2()
        {
            var res = _use.TypeTriangle(2, 1, 2);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void check_is_isosceles_triangle_2_2_1()
        {
            var res = _use.TypeTriangle(2, 2, 1);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void check_is_isosceles_triangle_55555_55555_66666()
        {
            var res = _use.TypeTriangle(55555, 55555, 66666);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void check_is_isosceles_triangle_66666_55555_55555()
        {
            var res = _use.TypeTriangle(66666, 55555, 55555);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void check_is_isosceles_triangle_55555_66666_55555()
        {
            var res = _use.TypeTriangle(55555, 66666, 55555);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void check_is_isosceles_triangle_99999998_99999999_99999999()
        {
            var res = _use.TypeTriangle(99999998, 99999999, 99999999);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void check_is_isosceles_triangle_99999999_99999999_99999998()
        {
            var res = _use.TypeTriangle(99999999, 99999999, 99999998);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void check_is_isosceles_triangle_99999999_99999998_99999999()
        {
            var res = _use.TypeTriangle(99999999, 99999998, 99999999);
            Assert.AreEqual(true, res);
        }

        [TestMethod]
        public void check_is_versatile_triangle_2_3_4()
        {
            var res = _use.TypeTriangle(2, 3, 4);
            Assert.AreEqual(false, res);
        }

        [TestMethod]
        public void check_is_versatile_triangle_2_4_3()
        {
            var res = _use.TypeTriangle(2, 4, 3);
            Assert.AreEqual(false, res);
        }

        [TestMethod]
        public void check_is_versatile_triangle_3_2_4()
        {
            var res = _use.TypeTriangle(3, 2, 4);
            Assert.AreEqual(false, res);
        }

        [TestMethod]
        public void check_is_versatile_triangle_3_4_2()
        {
            var res = _use.TypeTriangle(3, 4, 2);
            Assert.AreEqual(false, res);
        }

        [TestMethod]
        public void check_is_versatile_triangle_4_2_3()
        {
            var res = _use.TypeTriangle(4, 2, 3);
            Assert.AreEqual(false, res);
        }

        [TestMethod]
        public void check_is_versatile_triangle_4_3_2()
        {
            var res = _use.TypeTriangle(4, 3, 2);
            Assert.AreEqual(false, res);
        }






    }
}
