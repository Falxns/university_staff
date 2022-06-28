using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MiAPR_3
{
    public partial class Form1 : Form
    {

        public Form1()
        {
            InitializeComponent();
        }

        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < '0' || e.KeyChar > '9') && e.KeyChar != 8 && e.KeyChar != ',')
                e.KeyChar = '\0';
        }

        private void button1_Click(object sender, EventArgs e)
        {
            const int pointsCount = 10000;
            const int offset = 150;
            const int scaleMode = 250000;
            const double Eps = 0.001;

            int[] pointsArray1 = new int[pointsCount];
            int[] pointsArray2 = new int[pointsCount];
            double x, borderX;
            double mu1 = 0, mu2 = 0, sigma1 = 0, sigma2 = 0;
            double PC1, PC2, p1 = 0, p2 = 0;
            double falseAlarmError = 0, missingDetectingError = 0, totalClassificationError = 0;

            Graphics graphics;
            BufferedGraphicsContext bufferedGraphicsContext;
            BufferedGraphics bufferedGraphics;



            graphics = pictureBox1.CreateGraphics();
            bufferedGraphicsContext = new BufferedGraphicsContext();
            bufferedGraphics = bufferedGraphicsContext.Allocate(graphics,
                new Rectangle(0, 0, pictureBox1.Width, pictureBox1.Height));

            bufferedGraphics.Graphics.Clear(pictureBox1.BackColor);

            PC1 = double.Parse(textBox1.Text);
            PC2 = double.Parse(textBox2.Text);
            if ((PC1 > 1) || (PC2 > 1))
                MessageBox.Show("Значения вероятностей должны быть не больше 1.", "Ошибка ввода данных",
                                MessageBoxButtons.OK, MessageBoxIcon.Information);
            else
                if (((PC1 + PC2) != 1))
                    MessageBox.Show("Cумма вероятностей должна быть равна 1.", "Ошибка ввода данных",
                                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                else
                {
                    Random rand = new Random();

                    for (int i = 0; i < pointsCount; i++)
                    {
                        pointsArray1[i] = rand.Next(pictureBox1.Width) - offset;
                        pointsArray2[i] = rand.Next(pictureBox1.Width) + offset;
                    }

                    bufferedGraphics.Graphics.DrawRectangle(new Pen(Color.Black, 1), 0, 0,
                        pictureBox1.Width - 1, pictureBox1.Height - 1);

                    for (int i = 0; i < pointsCount; i++)
                    {
                        mu1 += pointsArray1[i];
                        mu2 += pointsArray2[i];
                    }
                    mu1 /= pointsCount;
                    mu2 /= pointsCount;
                    for (int i = 0; i < pointsCount; i++)
                    {
                        sigma1 += Math.Pow(pointsArray1[i] - mu1, 2);
                        sigma2 += Math.Pow(pointsArray2[i] - mu2, 2);
                    }
                    sigma1 = Math.Sqrt(sigma1 / pointsCount);
                    sigma2 = Math.Sqrt(sigma2 / pointsCount);

                    for (x = 0; x < pointsCount; x++)
                    {
                        p1 = Math.Exp(-0.5 * Math.Pow((x - mu1) / sigma1, 2)) /
                            (sigma1 * Math.Sqrt(2 * Math.PI));
                        bufferedGraphics.Graphics.FillRectangle(new SolidBrush(Color.Purple),
                            (int)(x), pictureBox1.Height - (int) (p1 * PC1 * scaleMode), 3, 3);
                    }
                    for (x = 0; x < pointsCount; x++)
                    {
                        p2 = Math.Exp(-0.5 * Math.Pow((x - mu2) / sigma2, 2)) /
                            (sigma2 * Math.Sqrt(2 * Math.PI));
                        bufferedGraphics.Graphics.FillRectangle(new SolidBrush(Color.Orange),
                             (int)(x), pictureBox1.Height - (int) (p2 * PC2 * scaleMode), 3, 3);
                    }

                    x = -offset;
                    p1 = 1;
                    p2 = 0;
                    if (PC2 != 0)
                        while (p2 < p1)
                        {
                            p1 = PC1 * Math.Exp(-0.5 * Math.Pow((x - mu1) / sigma1, 2)) /
                                (sigma1 * Math.Sqrt(2 * Math.PI));
                            p2 = PC2 * Math.Exp(-0.5 * Math.Pow((x - mu2) / sigma2, 2)) /
                                (sigma2 * Math.Sqrt(2 * Math.PI));
                            falseAlarmError += p2 * Eps;
                            x += Eps;
                        }
                    borderX = x;
                    while (x < pictureBox1.Width + 100)
                    {
                        p1 = Math.Exp(-0.5 * Math.Pow((x - mu1) / sigma1, 2)) /
                            (sigma1 * Math.Sqrt(2 * Math.PI));
                        p2 = Math.Exp(-0.5 * Math.Pow((x - mu2) / sigma2, 2)) /
                            (sigma2 * Math.Sqrt(2 * Math.PI));
                        missingDetectingError += p1 * PC1 * Eps;
                        x += Eps;
                    }

                    bufferedGraphics.Graphics.DrawLine(new Pen(Color.Green, 3),
                        (int)(borderX), 0, (int)(borderX), pictureBox1.Height);

                    if (PC1 == 0)
                    {
                        falseAlarmError = 1;
                        missingDetectingError = 0;
                        totalClassificationError = 1;
                    }
                    else
                    {
                        if (PC2 == 0)
                        {
                            falseAlarmError = 0;
                            missingDetectingError = 0;
                            totalClassificationError = 0;
                        }
                        else
                        {
                            falseAlarmError /= PC1;
                            missingDetectingError /= PC1;
                        }
                    }

                    totalClassificationError = falseAlarmError + missingDetectingError;
                    textBox3.Text = falseAlarmError.ToString();
                    textBox4.Text = missingDetectingError.ToString();
                    textBox5.Text = totalClassificationError.ToString();

                    bufferedGraphics.Render();
                }
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
