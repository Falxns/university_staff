using System;
using System.Windows.Forms;
using static System.Char;
using System.IO;

namespace TrianglesTask
{
    public partial class Form1 : Form
    {
        private const string FilePath = "./input.txt";

        public Form1()
        {
            InitializeComponent();
        }
        
        private void button1_Click(object sender, EventArgs e)
        {
            richTextBox1.Text =TriangleChecker.Resolve(textBox1.Text, textBox2.Text, textBox3.Text);
            
        }

        private void textBox_KeyPress(object sender, KeyPressEventArgs e)
        {
            char number = e.KeyChar;

            if (!IsDigit(number) && number != 8)
            {
                e.Handled = true;
            }
        }

        private void CheckValue(TextBox textBox)
        {
            if (textBox.Text.Length > 0 && textBox.Text[0] == '0')
            {
                textBox.Text = textBox.Text.Substring(1, textBox.Text.Length - 1);
            }
        }

        private void textBox_TextChanged(object sender, EventArgs e)
        {
            CheckValue((TextBox)sender);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            string[] MyArr = new string[3];
            using (FileStream fstream = File.OpenRead(FilePath))
            {
                byte[] array = new byte[fstream.Length];
                fstream.Read(array, 0, array.Length);
                string textFromFile = System.Text.Encoding.Default.GetString(array);
                int box = 0;
                for (int i = 0; i < textFromFile.Length; i++)
                {           
             
                    if (Convert.ToUInt32(textFromFile[i]) != 32)                   
                        MyArr[box] += textFromFile[i];                 
                    else
                    {
                        box++;
                        if (box == 3)
                            break;
                    }
                }
            }

            textBox1.Text = MyArr[0];
            textBox2.Text = MyArr[1];
            textBox3.Text = MyArr[2];
        }
    }
}
