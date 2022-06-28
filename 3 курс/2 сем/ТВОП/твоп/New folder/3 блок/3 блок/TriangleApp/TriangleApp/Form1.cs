using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TriangleApp
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        public bool isTriangle(int A, int B, int C)
        {
            if ((A + B > C) && (A + C > B) && (C + B > A))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private void OkButton_Click(object sender, EventArgs e)
        {
            int A = Convert.ToInt32(firstTextBox.Text);
            int B = Convert.ToInt32(secondTextBox.Text);
            int C = Convert.ToInt32(thirdTextBox.Text);
            if (!isTriangle(A, B, C))
            {
                MessageBox.Show("Треугольник с данными длинами сторон не существует. Сумма двух сторон должна быть всегда больше третьей. Повторите ввод.", "Неккоректный ввод", MessageBoxButtons.OK);
                firstTextBox.Text = "";
                secondTextBox.Text = "";
                thirdTextBox.Text = "";
            }
            else
            {
                if (TypeTriangle(A, B, C))
                {
                    if (isTriangleEquals(A, B, C))
                    {
                        MessageBox.Show("Треугольник равносторонний", "Тип треугольника", MessageBoxButtons.OK);
                    }
                    else
                    {
                        MessageBox.Show("Треугольник равнобедренный", "Тип треугольника", MessageBoxButtons.OK);
                    }
                }
                else
                {
                    MessageBox.Show("Треугольник неравносторонний", "Тип треугольника", MessageBoxButtons.OK);
                }
            }
        }

        public bool TypeTriangle(int A, int B, int C)
        {
            if ((A == B) || (A == C) || (B == C))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool isTriangleEquals(int A, int B, int C)
        {
            if (A == C && A == B && C == B)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private void firstTextBox_KeyPress(object sender, KeyPressEventArgs e)
        {

            if (Char.IsDigit(e.KeyChar) || e.KeyChar == (char)Keys.Back)
                return;
            else
                e.Handled = true;



            if (e.KeyChar == (char)Keys.Enter)
            {
                if (OkButton.Enabled == true)
                {
                    OkButton_Click(sender, e);
                }
            }
        }

        private void firstTextBox_TextChanged(object sender, EventArgs e)
        {

            (sender as TextBox).Text = (sender as TextBox).Text.Trim();
            if (!int.TryParse((sender as TextBox).Text, out int res))
            {
                //  (sender as TextBox).Text = "";
                List<char> l = (sender as TextBox).Text.ToList();
                string st = "";
                foreach (var item in l)
                {
                    if (char.IsDigit(item))
                    {
                        st += item;
                    }
                }
                (sender as TextBox).Text = st;

            }


            bool isCorrect = true;
            CheckValue((TextBox)sender);
            if (IsTextBoxEmpty(firstTextBox.Text))
            {
                isCorrect = false;
                Clear1.Enabled = false;
            }
            else
            {
                Clear1.Enabled = true;
            }
            if (IsTextBoxEmpty(secondTextBox.Text))
            {
                isCorrect = false;
                Clear2.Enabled = false;
            }
            else
            {
                Clear2.Enabled = true;
            }
            if (IsTextBoxEmpty(thirdTextBox.Text))
            {
                isCorrect = false;
                Clear3.Enabled = false;
            }
            else
            {
                Clear3.Enabled = true;
            }

            if ((!IsTextBoxEmpty(firstTextBox.Text) && !IsTextBoxEmpty(secondTextBox.Text))
                || (!IsTextBoxEmpty(firstTextBox.Text) && !IsTextBoxEmpty(thirdTextBox.Text))
                || (!IsTextBoxEmpty(secondTextBox.Text) && !IsTextBoxEmpty(thirdTextBox.Text)))
            {
                ClearAllButton.Enabled = true;
            }
            else
            {
                ClearAllButton.Enabled = false;
            }
            OkButton.Enabled = isCorrect;
        }

        public bool IsTextBoxEmpty(string textBox)
        {
            return textBox.Length == 0;
        }

        public void CheckValue(TextBox textBox)
        {
            if (textBox.Text.Length > 0)
            {
                if (textBox.Text[0] == '0')
                {
                    textBox.Text = textBox.Text.Substring(1, textBox.Text.Length - 1);
                }
            }
        }

        private void MainForm_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
            {
                if (OkButton.Enabled == true)
                {
                    OkButton_Click(sender, e);
                }
            }
        }

        private void ClearAllButton_Click(object sender, EventArgs e)
        {
            firstTextBox.Text = "";
            secondTextBox.Text = "";
            thirdTextBox.Text = "";
        }

        private void Clear1_Click(object sender, EventArgs e)
        {
            firstTextBox.Text = "";
        }

        private void Clear2_Click(object sender, EventArgs e)
        {
            secondTextBox.Text = "";
        }

        private void Clear3_Click(object sender, EventArgs e)
        {
            thirdTextBox.Text = "";
        }

        private void InfoButton_Click(object sender, EventArgs e)
        {
            MessageBox.Show("-Программа позволяет определить тип треугольника, если это возможно:\n" +
                "*равносторонний;\n" +
                "*равнобедренный;\n" +
                "*неравносторонний;\n\n" +
                "-Необходимо ввести 3 целых числа, которые интерпретируются как длины сторон треугольника.\n" +
                "-Далее программа выводит сообщение о том, является ли треугольник неравносторонним, равнобедренным или равносторонним.\n\n" +
                "-Максимальный размер сторон треугольника для определение типа:\n" +
                "размер каждой стороны - целое положительное число в диапазоне от 1 до 99999999 включительно.", "ИНФОРМАЦИЯ",
                MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
        }
    }
}
