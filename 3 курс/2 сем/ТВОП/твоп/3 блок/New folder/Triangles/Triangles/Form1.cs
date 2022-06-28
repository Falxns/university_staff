using System;
using System.Globalization;
using System.IO;
using System.Text.RegularExpressions;
using System.Windows.Forms;

namespace Triangles
{

    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            firstSide.MaxLength = 9;
            secondSide.MaxLength = 9;
            thirdSide.MaxLength = 9;

            clearStripButton.Enabled = true;
            //firstButton.Enabled = false;
            //secondButton.Enabled = false;
            //thirdButton.Enabled = false;
            calculateButton.Enabled = false;

            firstSide.ShortcutsEnabled = false;
            secondSide.ShortcutsEnabled = false;
            thirdSide.ShortcutsEnabled = false;
        }

        public bool check_values(string s1, string s2, string s3)
        {
            string pattern = @"[1-9]{1}[0-9]+";
            if (Regex.Match(s1, pattern) == null ||
                Regex.Match(s2, pattern) == null
                || Regex.Match(s3, pattern) == null)
                return false;
            else
                return true;
        }
        
        /// <summary>
        /// Check existence of triangle
        /// </summary>
        /// <param name="s1">First parameter</param>
        /// <param name="s2">Second parameter</param>
        /// <param name="s3">Third parameter</param>
        /// <returns>Boolean (true or false)</returns>
        public bool Valid_Triangle(string s1, string s2, string s3)
        {
            int first; int second; int third;
            
            try
            {
                if (s1 != null && s1.Length > 9)
                    return false;
                if (s2!= null && s2.Length > 9)
                    return false;
                if (s3!= null && s3.Length > 9)
                    return false;
                first = int.Parse(s1, NumberStyles.None);
                second = int.Parse(s2, NumberStyles.None);
                third = int.Parse(s3, NumberStyles.None);
            }
            catch
            {
                return false;
            }
            if ((first + second) <= third || (first + third) <= second || (second + third) <= first)
                return false;
            else
                return true;
        }
      
        public int[] Parser(bool flag, int[] arrayResult)//true read
        {
            
            string path;
            if (flag)
            {
                arrayResult = new int[3];
                int i = -1;
                path = @"C:\Users\Asus-PC\Desktop\Новая папка\3 курс\твоп\3 блок\New folder\Triangles\input.txt";
                using (StreamReader read = new StreamReader(path))
                {
                    string line = read.ReadToEnd();

                    if(Regex.IsMatch(line, @"^([1-9]{1}[0-9]{0,8};){3}"))
                    {
                        foreach(string s in line.Split(';'))
                            if(s!="")
                            arrayResult[++i] = Int32.Parse(s);
                        return arrayResult;
                    }
                    else
                    {
                        MessageBox.Show("Неверный формат данных файла");
                        return null;
                    }
                   // MatchCollection matches = Regex.Matches(line, @"\(([1-9]+0*){9}|)+");


                }
            }
            else
            {
                path = @"C:\Users\Asus-PC\Desktop\Новая папка\3 курс\твоп\3 блок\New folder\Triangles\result.txt";
                using(StreamWriter write = new StreamWriter(path))
                {
                    string lineToWrite = arrayResult.ToString();
                    write.WriteLine(lineToWrite);
                    return null;
                }
            }
        }
        public string Get_Triangle_Type(string s1, string s2, string s3)
        {
            if (!Valid_Triangle(s1, s2, s3))
                return null;
            int first; int second; int third;
            try
            {
                first = int.Parse(s1, NumberStyles.None);
                second = int.Parse(s2, NumberStyles.None);
                third = int.Parse(s3, NumberStyles.None);
            }
            catch
            {
                return null;
            }

            string triangleType = "";
            if (first == second && second == third)
                triangleType = "Равносторонний";
            else
            {
                if (first == second || second == third || third == first)
                    triangleType = "Равнобедреный";
                else
                    triangleType = "Неравносторонний";
            }
            return triangleType;
        }

        public void CalculateButtonTapped(object sender, EventArgs e)
        {

            if (!check_values(firstSide.Text, secondSide.Text, thirdSide.Text)) {
                MessageBox.Show("Программа принимает на вход три натуральных числа в диапазоне 1 до 999999999");
                clearStripButton_Click(sender, e);
                return;
            }
            int first, second, third;
            first = int.Parse(firstSide.Text);
            second = int.Parse(secondSide.Text);
            third = int.Parse(thirdSide.Text);

           if (!Valid_Triangle(firstSide.Text, secondSide.Text, thirdSide.Text))
            {
                MessageBox.Show("Треугольник с данными длинами сторон не существует. Сумма двух сторон должна быть больше третьей стороны. Повторите ввод!","Error",MessageBoxButtons.OK, MessageBoxIcon.Error);
                clearStripButton_Click(sender, e);
                return;
            }
            if (first == second && second == third)
                label6.Text = "Равносторонний";
            else
            {
                if (first == second || second == third || third == first)
                    label6.Text = "Равнобедреный";
                else
                    label6.Text = "Неравносторонний";
            }

            try
            {
                string path = @"C:\Users\Asus-PC\Desktop\Новая папка\3 курс\твоп\3 блок\New folder\Triangles\result.txt";
                using (StreamWriter write = new StreamWriter(path))
                {
                    write.WriteLine($"Первая сторона: {first.ToString()}, Вторая сторона: {second.ToString()}, " +
                        $"Третья сторона: {third.ToString()}, Тип треугольника: {label6.Text}");
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show("vu idiot " + ex.Message);
            }
        }

        private bool Key_Check(object sender, KeyPressEventArgs e)
        {
            TextBox textBox = (TextBox)sender;
            if ((e.KeyChar == (char)Keys.D0) && (textBox.SelectionStart == 0))
                return false;
            if (textBox.Text == "" && e.KeyChar == (char)Keys.D0)
                return false;
          //  if (e.Modifiers == Keys.Shift || e.Modifiers == Keys.Alt) return false;
            if (e.KeyChar >= (char)Keys.D0 && e.KeyChar <= (char)Keys.D9)
                return true;
            if (e.KeyChar == (char)Keys.Delete || e.KeyChar == (char)Keys.Back)
                return true;
            //else
            //    return false;
            //if (e.KeyChar == (char)Keys.Left || e.KeyChar == (char)Keys.Right) return false;
            if (Char.IsDigit(e.KeyChar) || e.KeyChar == (char)Keys.Back) return true; else return false;

        }

        private void number_Check(object sender, KeyPressEventArgs e)
        {          
            e.Handled = Key_Check(sender, e) ? false : true;
        }

        private void clearStripButton_Click(object sender, EventArgs e)
        {
            firstSide.Text = "";
            secondSide.Text = "";
            thirdSide.Text = "";
            firstSide.Enabled = true;
            secondSide.Enabled = true;
            thirdSide.Enabled = true;
            

            label6.Text = "...";
        }

        private void infoStripButton_Click(object sender, EventArgs e)
        {
            MessageBox.Show("-Программа позволяет определить тип треугольника, если это возможно:\n" +
                            "*равносторонний;\n" + "*равнобедренный;\n" + "*неравносторонний;\n\n" +
                            "-Необходимо ввести 3 целых числа, которые интерпретируются как длины сторон треугольника.\n" +
                            "-Далее программа выводит сообщение о том, является ли треугольник неравносторонним, равнобедренным или равносторонним.\n\n" +
                            "-Максимальный размер сторон треугольника для определение типа:\n" +
                            "размер каждой стороны - целое положительное число в диапазоне от 1 до 999999999 включительно.\n\n" +
                            "-Для альтернативного ввода, добавлен ввод из файла, расположенного в папке проекта.", "О программе",
                            MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void exitStripButton_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Goodbye");
            Application.Exit();
        }

        public void ClearStripButton_Enable()
        {
            if (firstSide.Text != "" && secondSide.Text != "" && thirdSide.Text != "")
            {
               // clearStripButton.Enabled = true;
                calculateButton.Enabled = true;
            }
            else
            {
               // clearStripButton.Enabled = false;
                calculateButton.Enabled = false;
            }
        }

        private void Valid_textbox(TextBox textBox, Button button)
        {
            button.Enabled = textBox.Text != "" ? true : false;
            ClearStripButton_Enable();
        }

        private void firstSide_TextChanged(object sender, EventArgs e)
        {
            // firstButton.Enabled = firstSide.Text != "" ? true : false;
            if (Regex.IsMatch(firstSide.Text, @"^0+$"))
            {
                MessageBox.Show("Значение стороны должно быть больше нуля!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                firstSide.Text = "";
            }
            ClearStripButton_Enable();
        }

        private void secondSide_TextChanged(object sender, EventArgs e)
        {
            // secondButton.Enabled = secondSide.Text != "" ? true : false;
            if (Regex.IsMatch(secondSide.Text, @"^0+$"))
            {
                MessageBox.Show("Значение стороны должно быть больше нуля!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                secondSide.Text = "";
            }
            ClearStripButton_Enable();
        }

        private void thirdSide_TextChanged(object sender, EventArgs e)
        {
            // thirdButton.Enabled = thirdSide.Text != "" ? true : false;
            if (Regex.IsMatch(thirdSide.Text, @"^0+$"))
            {
                MessageBox.Show("Значение стороны должно быть больше нуля!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                thirdSide.Text = "";
            }
            ClearStripButton_Enable();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void downloadButton_Click(object sender, EventArgs e)
        {
            try
            {
                int[] arr = new int[3];
                string path;
                int i = -1;
                path = @"C:\Users\Asus-PC\Desktop\Новая папка\3 курс\твоп\3 блок\New folder\Triangles\input.txt";
                using (StreamReader read = new StreamReader(path))
                {
                    string line = read.ReadToEnd();

                    if (Regex.IsMatch(line, @"^([1-9]{1}[0-9]{0,8};){3}$"))
                    {
                        foreach (string s in line.Split(';'))
                            if (s != "")
                                arr[++i] = Int32.Parse(s);
                    }
                    else
                    {
                        MessageBox.Show("Неверный формат данных файла");
                        return;
                    }
                }
                firstSide.Text = arr[0].ToString();
                secondSide.Text = arr[1].ToString();
                thirdSide.Text = arr[2].ToString();
                //firstSide.Enabled = false;
                //secondSide.Enabled = false;
                //thirdSide.Enabled = false;
            }
            catch (Exception ex)
            {
                MessageBox.Show("vu idiot " + ex.Message);
            }
        }
    }
    
}
