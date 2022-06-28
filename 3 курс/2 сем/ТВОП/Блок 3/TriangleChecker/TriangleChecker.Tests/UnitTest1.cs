using NUnit.Framework;

namespace TriangleChecker.Tests
{
    [TestFixture]
    public class TriangleCheckerTests
    {
        private const string ISOSCELES_TRIANGLE = "Треугольник равнобедренный.";
        private const string EQUILATERAL_TRIANGLE = "Треугольник равносторонний.";
        private const string NOT_EQUILATERAL_TRIANGLE = "Треугольник неравносторонний.";
        private const string ERROR_INCORRECT_NUMBER_INPUT =
            "Введённое значение должно быть целым числом и находиться в интервале [1;2147483647]. Повторите ввод.";
       
        
        private const string ERROR_TRIANGLE_DONT_EXIST =
            "Из данных сторон нельзя составить треугольник." +
            " Сумма длин двух любых сторон треугольника не должна быть больше третьей стороны. Повторите ввод.";

        
        [TestCase(" ", "4", "5", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("4", " ", "5", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("4", "5", " ", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase(" ", " ", " ", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]

        [TestCase("щ", "%", "G", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("щ", "1", "1", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("1", "%", "1", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("1", "1", "G", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]

        [TestCase("0", "0", "0", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("0", "1", "1", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("1", "0", "1", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("1", "1", "0", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]

        [TestCase("-1", "2", "3", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("1", "-2", "3", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("1", "2", "-3", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("-3", "-4", "-5", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]

        [TestCase("2147483648", "1", "2", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("1", "2147483648", "2", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("1", "1", "2147483648", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("2147483648", "2147483648", "2147483648", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]

        [TestCase("1.1", "1", "1", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("1", "1.1", "1", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("1", "1", "1.1", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]
        [TestCase("1.1", "1.1", "1.1", ExpectedResult = ERROR_INCORRECT_NUMBER_INPUT)]

        [TestCase("1", "1", "2", ExpectedResult = ERROR_TRIANGLE_DONT_EXIST)]
        [TestCase("1", "2", "1", ExpectedResult = ERROR_TRIANGLE_DONT_EXIST)]
        [TestCase("2", "1", "1", ExpectedResult = ERROR_TRIANGLE_DONT_EXIST)]

        [TestCase("1", "1", "3", ExpectedResult = ERROR_TRIANGLE_DONT_EXIST)]
        [TestCase("3", "1", "1", ExpectedResult = ERROR_TRIANGLE_DONT_EXIST)]
        [TestCase("1", "3", "1", ExpectedResult = ERROR_TRIANGLE_DONT_EXIST)]

        [TestCase("1", "1", "1", ExpectedResult = EQUILATERAL_TRIANGLE)]
        [TestCase("4444444", "4444444", "4444444", ExpectedResult = EQUILATERAL_TRIANGLE)]
        [TestCase("2147483647", "2147483647", "2147483647", ExpectedResult = EQUILATERAL_TRIANGLE)]

        [TestCase("1", "2", "2", ExpectedResult = ISOSCELES_TRIANGLE)]
        [TestCase("2", "2", "1", ExpectedResult = ISOSCELES_TRIANGLE)]
        [TestCase("2", "1", "2", ExpectedResult = ISOSCELES_TRIANGLE)]
        [TestCase("4444444", "6666666", "4444444", ExpectedResult = ISOSCELES_TRIANGLE)]

        [TestCase("2", "3", "4", ExpectedResult = NOT_EQUILATERAL_TRIANGLE)]
        [TestCase("10", "11", "12", ExpectedResult = NOT_EQUILATERAL_TRIANGLE)]
        [TestCase("2147483647", "2147483646", "2147483645", ExpectedResult = NOT_EQUILATERAL_TRIANGLE)]


        public string Triangle_Check(string first, string second, string third)
            => TriangleChecker.Resolve(first, second, third);
    }
}
