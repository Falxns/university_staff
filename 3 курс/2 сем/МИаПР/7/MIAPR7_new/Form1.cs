using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace MiAPR_7
{
    public partial class Form1 : Form
    {
        Dictionary<string, Bitmap> bitmaps;
        Dictionary<string, Point> beginPositions;
        Dictionary<string, Point> endPositions;

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            string folder = AppDomain.CurrentDomain.BaseDirectory;
            string[] files = Directory.GetFiles(folder, "*.png");

            bitmaps = new Dictionary<string, Bitmap>();
            beginPositions = new Dictionary<string, Point>();
            endPositions = new Dictionary<string, Point>();

            for (int i = 0; i < files.Length; i++)
            {
                var bitmap = new Bitmap(files[i]);
                string[] temp = files[i].Split('\\', '.');

                bitmaps.Add(temp[temp.Length - 2], bitmap);
                comboBox_Primitives.Items.Add(temp[temp.Length - 2]);
            }
        }

        private void button_Clear_Click(object sender, EventArgs e)
        {
            pictureBox_Man.Refresh();
            beginPositions.Clear();
            endPositions.Clear();
            comboBox_Primitives.Items.Clear();

            foreach (string key in bitmaps.Keys)
                comboBox_Primitives.Items.Add(key);
        }

        private void pictureBox_Man_MouseDown(object sender, MouseEventArgs e)
        {
            if (comboBox_Primitives.SelectedItem != null)
            {
                string comboBoxItem = comboBox_Primitives.SelectedItem.ToString();
                Bitmap bitmap = bitmaps[comboBoxItem];
                Graphics g = pictureBox_Man.CreateGraphics();
                Point beginPosition = new Point(e.X - bitmap.Width / 2, e.Y - bitmap.Height / 2);
                Point endPosition;

                g.DrawImage(bitmap, beginPosition);
                beginPositions.Add(comboBoxItem, beginPosition);

                if (comboBoxItem == "head")
                {
                    endPosition = new Point(beginPositions["head"].X + 100, 
                        beginPositions["head"].Y + 100);
                    endPositions.Add(comboBoxItem, endPosition);
                }
                if (comboBoxItem == "body")
                {
                    endPosition = new Point(beginPositions["body"].X + 200, 
                        beginPositions["body"].Y + 200);
                    endPositions.Add(comboBoxItem, endPosition);
                }
                if (comboBoxItem == "hands")
                {
                    endPosition = new Point(beginPositions["hands"].X + 500, 
                        beginPositions["hands"].Y + 70);
                    endPositions.Add(comboBoxItem, endPosition);
                }
                if (comboBoxItem == "feet")
                {
                    endPosition = new Point(beginPositions["feet"].X + 200, 
                        beginPositions["feet"].Y + 200);
                    endPositions.Add(comboBoxItem, endPosition);
                }
                if (comboBoxItem == "ice_cream")
                {
                    endPosition = new Point(beginPositions["ice_cream"].X + 50, 
                        beginPositions["ice_cream"].Y + 100);
                    endPositions.Add(comboBoxItem, endPosition);
                }

                comboBox_Primitives.Items.RemoveAt(comboBox_Primitives.Items.IndexOf(comboBoxItem));
            }
        }

        private void button_Analysis_Click(object sender, EventArgs e)
        {
            if (comboBox_Primitives.Items.Count > 0)
                MessageBox.Show("Человек не обнаружен.");
            else
                if ((beginPositions["body"].X > 150) && (endPositions["body"].X < 650) && (beginPositions["body"].Y > 100) && (endPositions["body"].Y < 400))
                    if ((beginPositions["head"].X > beginPositions["body"].X) && (endPositions["head"].X < endPositions["body"].X) && (beginPositions["head"].Y > beginPositions["body"].Y - 150) && (endPositions["head"].Y < beginPositions["body"].Y + 50))
                        if ((beginPositions["hands"].X > beginPositions["body"].X - 200) && (endPositions["hands"].X < endPositions["body"].X + 200) && (beginPositions["hands"].Y > beginPositions["body"].Y) && (endPositions["hands"].Y < endPositions["body"].Y))
                            if ((beginPositions["feet"].X > beginPositions["body"].X - 50) && (endPositions["feet"].X < endPositions["body"].X + 50) && (beginPositions["feet"].Y > endPositions["body"].Y - 50) && (endPositions["feet"].Y < endPositions["body"].Y + 250))
                            {
                                if (radioButton1.Checked)
                                    if ((beginPositions["ice_cream"].X > beginPositions["hands"].X - 50) && (endPositions["ice_cream"].X < beginPositions["hands"].X + 50) && (beginPositions["ice_cream"].Y > beginPositions["hands"].Y - 50) && (endPositions["ice_cream"].Y < endPositions["hands"].Y + 50))
                                        MessageBox.Show("Обнаружен человек с мороженым в левой руке!");
                                    else
                                        MessageBox.Show("Человек не обнаружен. Мороженое находится не в левой руке.");
                                if (radioButton2.Checked)
                                    if ((beginPositions["ice_cream"].X > endPositions["hands"].X - 50) && (endPositions["ice_cream"].X < endPositions["hands"].X + 50) && (beginPositions["ice_cream"].Y > beginPositions["hands"].Y - 50) && (endPositions["ice_cream"].Y < endPositions["hands"].Y + 50))
                                        MessageBox.Show("Обнаружен человек с мороженым в правой руке!");
                                    else
                                        MessageBox.Show("Человек не обнаружен. Мороженое находится не в правой руке.");
                            }
                            else
                                MessageBox.Show("Человек не обнаружен. Сильно смещены ноги.");
                        else
                            MessageBox.Show("Человек не обнаружен. Сильно смещены руки.");
                    else
                        MessageBox.Show("Человек не обнаружен. Сильно смещена голова.");
                else
                    MessageBox.Show("Человек не обнаружен. Объект зашёл за границу.");
        }
    }
}