using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
//using System.Window.F
using Triangles;

namespace UnitTestProject1
{
    [TestClass()]
    public class UnitTest1
    {
        Form1 appInstance;
        [TestInitialize]
        public void Init()
        {
            appInstance = new Form1();
        }

        public TestContext TestContext { get; set; }
        [DeploymentItem("UnitTestProject1\\Sides.xml")]
        [DataSource(
         "Microsoft.VisualStudio.TestTools.DataSource.XML",
          "|DataDirectory|\\Sides.xml",
         "TestCase",
         DataAccessMethod.Sequential)]
        //тут если скопировать хмл в бин дебаг все будет работать
        //но я не хочу оттуда поэтому искала дргуие директории- не нашла, заебалась
        // пошла делать нюниты
        [TestMethod]
        public void TestMethod1()
        {
            string firstSide = Convert.ToString(TestContext.DataRow["FirstSide"]);
            string secondSide = Convert.ToString(TestContext.DataRow["SecondSide"]);
            string thirdSide = Convert.ToString(TestContext.DataRow["ThirdSide"]);

            bool expected = Convert.ToBoolean(TestContext.DataRow["ExpectedResult"]);
            bool actual = appInstance.Valid_Triangle(firstSide, secondSide, thirdSide);
            
            Assert.AreEqual(expected, actual);
        }
    }
}
