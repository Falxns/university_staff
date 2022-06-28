using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MiAPR_1_VS
{
    public partial class MainForm : Form
    {
        private const int MIN_POINTS_COUNT = 10;
        private const int MAX_POINTS_COUNT = 1000000;
        private const int MIN_CLASS_COUNT = 2;
        private const int MAX_CLASS_COUNT = 128;
        private const int POINTS_WIDTH = 1;
        private const int KERNELS_WIDTH = 9;
        private const int INTEND = 5;    //Border width
        private const int MINAVERAGESQUAREDISTANCE = 5000;                                                                                                                                                                                                                                                                                                                          private const int PRECISION1 = 300;    //Точность 1
        private const int MAX_RGB_COMPONENT_VALUE = 256;                                                                                                                                                                                                                                                                                                                            private const int PRECISION2 = 20;     //Точность 2
        
        private struct point
        {
            public int x;
            public int y;
            public int Class;
        };
        
        private struct ClassDistance
        {
            public int Class;
            public double distance;
        };

        private int points_count, class_count;
        private Color[] Colors = new Color[MAX_CLASS_COUNT];
        private point[] Points = new point[MAX_POINTS_COUNT];
        private point[] OldKernels = new point[MAX_CLASS_COUNT];
        private point[] NewKernels = new point[MAX_CLASS_COUNT];
        private Graphics graphics;
        private BufferedGraphicsContext bufferedGraphicsContext;
        private BufferedGraphics bufferedGraphics;

        public MainForm()
        {
            Random rand = new Random();

            InitializeComponent();
            Colors[0] = Color.White;
            Colors[1] = Color.Yellow;
            Colors[2] = Color.Red;
            Colors[3] = Color.Lime;
            Colors[4] = Color.Blue;
            Colors[5] = Color.Aqua;
            Colors[6] = Color.Fuchsia;
            Colors[7] = Color.Orange;
            Colors[8] = Color.Green;
            Colors[9] = Color.Gray;
            for (int i = 10; i < MAX_CLASS_COUNT; i++)
                Colors[i] = newRGBcolor(rand.Next(MAX_RGB_COMPONENT_VALUE), 
                                        rand.Next(MAX_RGB_COMPONENT_VALUE), 
                                        rand.Next(MAX_RGB_COMPONENT_VALUE)); 
            graphics = pictureBox1.CreateGraphics();
            bufferedGraphicsContext = new BufferedGraphicsContext();
            bufferedGraphics = bufferedGraphicsContext.Allocate(graphics, 
                new Rectangle(0, 0, pictureBox1.Width, pictureBox1.Height));
            ClearForm();
        }
        
        private Color newRGBcolor(int r, int g, int b)
        {
            Color RGBcolor = new Color();

            RGBcolor = Color.FromArgb(r, g, b);

            return RGBcolor;
        }

        private void ClearForm()
        {
            ClearImage();
            textBox1.Text = "100000";
            textBox2.Text = "20";
            points_count = int.Parse(textBox1.Text);
            class_count = int.Parse(textBox2.Text);

            dataGridView1.ColumnCount = 2;
            dataGridView1.RowCount = class_count + 1;
            dataGridView1.Columns[0].Width = dataGridView1.Columns[1].Width = 115;
            dataGridView1.Rows[0].Cells[0].Value = "Класс:";
            dataGridView1.Rows[0].Cells[1].Value = "Кол точек:";
            for (int i = 0; i < class_count; i++)
            {
                dataGridView1.Rows[i + 1].Cells[0].Value = "";
                dataGridView1.Rows[i + 1].Cells[1].Value = "";
            }

            button1.Enabled = true;
            button2.Enabled = true;
            button3.Enabled = false;
            button1.Focus();
        }

        private void ClearImage()
        {
            bufferedGraphics.Graphics.Clear(pictureBox1.BackColor);
        }

        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < '0' || e.KeyChar > '9') && e.KeyChar != 8)
                e.KeyChar = '\0';
        }

        private double EvklidDistance(point a, point b)
        {
            return Math.Sqrt(Math.Pow((a.x - b.x), 2) + Math.Pow((a.y - b.y), 2));
        }

        private int min(int a, int b)
        {
            if (a < b)
                return a;
            else
                return b;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Random rand = new Random();

            points_count = int.Parse(textBox1.Text);
            class_count = int.Parse(textBox2.Text);

            if (points_count < MIN_POINTS_COUNT)
                points_count = MIN_POINTS_COUNT;
            if (points_count > MAX_POINTS_COUNT)
                points_count = MAX_POINTS_COUNT;
            if (class_count < MIN_CLASS_COUNT)
                class_count = MIN_CLASS_COUNT;
            if (class_count > MAX_CLASS_COUNT)
                class_count = MAX_CLASS_COUNT;

            if (points_count < class_count)
                points_count = class_count;
            textBox1.Text = points_count.ToString();
            textBox2.Text = class_count.ToString();

            for (int i = 0; i < points_count; i++)
            {
                Points[i].x = INTEND + rand.Next(pictureBox1.Width - 2 * INTEND);
                Points[i].y = INTEND + rand.Next(pictureBox1.Height - 2 * INTEND);
                Points[i].Class = 0;
                bufferedGraphics.Graphics.FillRectangle(new SolidBrush(Colors[Points[i].Class]),
                    Points[i].x, Points[i].y, POINTS_WIDTH, POINTS_WIDTH);
             }
            for (int i = 0; i < class_count; i++)
            {
                OldKernels[i] = NewKernels[i] = Points[rand.Next(points_count)];
                OldKernels[i].Class = NewKernels[i].Class = i;
                bufferedGraphics.Graphics.FillEllipse(new SolidBrush(Colors[NewKernels[i].Class]),
                    NewKernels[i].x, NewKernels[i].y, KERNELS_WIDTH, KERNELS_WIDTH);
             }
            for (int i = 0; i < class_count; i++)
            {
                dataGridView1.Rows[i + 1].Cells[0].Value = i + 1;
                dataGridView1.Rows[i + 1].Cells[1].Value = points_count / class_count; ;
            }

            bufferedGraphics.Render();
            button1.Enabled = false;
            button3.Enabled = true;
            button3.Focus();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ClearForm();
            bufferedGraphics.Render();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            int step = 0;
            DateTime start_time = DateTime.Now;
            bool is_class_change = true;
            string caption = "Найдены наилучшие ядра", message;

            while (is_class_change)
            {
                point[,] PointsInClasses = new point[class_count, MAX_POINTS_COUNT];
                int[] CountPointsInClasses = new int[class_count];

                step++;
                is_class_change = false;

                for (int i = 0; i < class_count; i++)
                {
                    OldKernels[i] = NewKernels[i];
                    CountPointsInClasses[i] = 0;
                }

                for (int i = 0; i < points_count; i++)   //Points classification
                {
                    ClassDistance[] distances = new ClassDistance[class_count];
                    ClassDistance min;

                    for (int j = 0; j < class_count; j++)
                    {
                        distances[j].Class = j;
                        distances[j].distance = EvklidDistance(Points[i], NewKernels[j]);
                    }

                    min.Class = distances[0].Class;
                    min.distance = distances[0].distance;
                    for (int k = 1; k < class_count; k++)
                        if (distances[k].distance < min.distance)
                        {
                            min.Class = distances[k].Class;
                            min.distance = distances[k].distance;
                        }
                    Points[i].Class = min.Class;
                    CountPointsInClasses[Points[i].Class]++;
                }

                for (int i = 0; i < class_count; i++)
                    dataGridView1.Rows[i + 1].Cells[1].Value = CountPointsInClasses[i];

                for (int i = 0; i < class_count; i++)   //Points distribution into classes 
                {
                    int TempCountPoints = 0;

                    for (int j = 0; j < points_count; j++)
                        if (Points[j].Class == i)
                        {
                            PointsInClasses[i, TempCountPoints] = Points[j];
                            TempCountPoints++;
                        }
                }

                for (int i = 0; i < class_count; i++)   //Search best kernels
                {
                    double MinAverageSquareDistance = MINAVERAGESQUAREDISTANCE;
                    int number = -1;

                    for (int j = 0; j < min(CountPointsInClasses[i], PRECISION1); j++)
                    {
                        double SumSquareDistance = 0, TempAverageSquareDistances;

                        for (int k = 0; k < min(CountPointsInClasses[i], PRECISION2); k++)
                            SumSquareDistance += Math.Pow(EvklidDistance(PointsInClasses[i, j],
                                                                         PointsInClasses[i, k]), 2);
                        TempAverageSquareDistances = Math.Sqrt(SumSquareDistance/CountPointsInClasses[i]);
                        if (TempAverageSquareDistances < MinAverageSquareDistance)   //Best kernel was found
                        {
                            MinAverageSquareDistance = TempAverageSquareDistances;
                            number = j;
                        }
                    }
                    if (number != -1)
                        NewKernels[i] = PointsInClasses[i, number];
                }

                for (int i = 0; i < class_count; i++)
                    if ((OldKernels[i].x != NewKernels[i].x) || (OldKernels[i].y != NewKernels[i].y))
                        is_class_change = true;

                ClearImage();   //Draw points with new kernels
                for (int i = 0; i < points_count; i++)
                    bufferedGraphics.Graphics.FillRectangle(new SolidBrush(Colors[Points[i].Class]),
                        Points[i].x, Points[i].y, POINTS_WIDTH, POINTS_WIDTH);
                for (int i = 0; i < class_count; i++)
                    bufferedGraphics.Graphics.FillEllipse(new SolidBrush(Colors[NewKernels[i].Class]),
                        NewKernels[i].x, NewKernels[i].y, KERNELS_WIDTH, KERNELS_WIDTH);
                bufferedGraphics.Render();
            }

            DateTime end_time = DateTime.Now;

            message = caption + " за " + (end_time - start_time).Minutes.ToString() + " мин " +
                                         (end_time - start_time).Seconds.ToString() + " с " +
                                         (end_time - start_time).Milliseconds.ToString() + " мс.";
            caption += '!';
            MessageBox.Show(message, caption, MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
    }
}