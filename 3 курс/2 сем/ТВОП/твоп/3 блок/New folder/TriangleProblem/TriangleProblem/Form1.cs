using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TriangleProblem
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            Size = new System.Drawing.Size(450, 325);
        }

        int a = 0;
        int b = 0;
        int c = 0;

        private void оПрограммеToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show(caption: "О программе", text: "Программа принимает на вход три натуральных числа в диапазоне от 1 до 100000000 включительно, которые интерпретируются как длины сторон треугольника. Далее программа после нажатия на кнопку \"Определить тип треугольника\" выводит сообщение о том, является ли треугольник с данными длинами строн неравносторонним, равнобедренным или равносторонним.");
        }

        private void выходToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show(caption: "О разработчике", text: "Программу разработала Журок Анна, студентка группы 651002.");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (textBox1.Text == "" || textBox2.Text == "" || textBox3.Text == "")
                MessageBox.Show(caption: "Ошибка", text: "Вы ввели не все значения длин сторон треугольника! Повторите ввод. Длины сторон треугольника должны быть целочисленными значениями в диапазоне от 1 до 100000000 включительно.");
            else
            {
                a = Convert.ToInt32(textBox1.Text);
                b = Convert.ToInt32(textBox2.Text);
                c = Convert.ToInt32(textBox3.Text);

                if (a > 100000000 || b > 100000000 || c > 100000000)
                    MessageBox.Show(caption: "Ошибка", text: "Длины сторон треугольника должны быть целочисленными значениями в диапазоне от 1 до 100000000 включительно. Повторите ввод.");

                else if ((a <= 0 || b <= 0 || c <= 0) || (a + b <= c || a + c <= b || b + c <= a))
                    MessageBox.Show(caption: "Ответ", text: "Треугольника с такими длинами сторон не существует! Сумма длин двух сторон всегда должна быть больше длины третьей стороны. Повторите ввод.");
                else if (a == b && b == c)
                    MessageBox.Show(caption: "Ответ", text: "Это равносторонний треугольник.");
                else if (a == b && b != c || a == c && c != b || b == c && c != a)
                    MessageBox.Show(caption: "Ответ", text: "Это равнобедренный треугольник.");
                else
                    MessageBox.Show(caption: "Ответ", text: "Это неравносторонний треугольник.");
            }
        }

        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            char ch = e.KeyChar;
            if (textBox1.Text.Length == 0)
                if (ch == '0') e.Handled = true;
            if (!Char.IsDigit(ch) && ch != 8)
                e.Handled = true;
            if (textBox1.Text.Length == 9 && ch != 8)
                e.Handled = true;
        }

        private void textBox2_KeyPress(object sender, KeyPressEventArgs e)
        {
            char ch = e.KeyChar;
            if (textBox2.Text.Length == 0)
                if (ch == '0') e.Handled = true;
            if (!Char.IsDigit(ch) && ch != 8)
                e.Handled = true;
            if (textBox2.Text.Length == 9 && ch != 8)
                e.Handled = true;
        }

        private void textBox3_KeyPress(object sender, KeyPressEventArgs e)
        {
            char ch = e.KeyChar;
            if (textBox3.Text.Length == 0)
                if (ch == '0') e.Handled = true;
            if (!Char.IsDigit(ch) && ch != 8)
                e.Handled = true;
            if (textBox3.Text.Length == 9 && ch != 8)
                e.Handled = true;
        }
    }
}
