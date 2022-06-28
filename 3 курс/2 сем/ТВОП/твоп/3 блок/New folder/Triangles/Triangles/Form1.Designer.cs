namespace Triangles
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.firstSide = new System.Windows.Forms.TextBox();
            this.secondSide = new System.Windows.Forms.TextBox();
            this.thirdSide = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.labelSecond = new System.Windows.Forms.Label();
            this.labelThird = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.calculateButton = new System.Windows.Forms.Button();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.clearStripButton = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.infoStripButton = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.downloadButton = new System.Windows.Forms.Button();
            this.toolStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // firstSide
            // 
            this.firstSide.Location = new System.Drawing.Point(26, 71);
            this.firstSide.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.firstSide.Name = "firstSide";
            this.firstSide.Size = new System.Drawing.Size(89, 22);
            this.firstSide.TabIndex = 0;
            this.firstSide.TextChanged += new System.EventHandler(this.firstSide_TextChanged);
            this.firstSide.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.number_Check);
            // 
            // secondSide
            // 
            this.secondSide.Location = new System.Drawing.Point(26, 115);
            this.secondSide.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.secondSide.Name = "secondSide";
            this.secondSide.Size = new System.Drawing.Size(89, 22);
            this.secondSide.TabIndex = 1;
            this.secondSide.TextChanged += new System.EventHandler(this.secondSide_TextChanged);
            this.secondSide.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.number_Check);
            // 
            // thirdSide
            // 
            this.thirdSide.Location = new System.Drawing.Point(26, 163);
            this.thirdSide.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.thirdSide.Name = "thirdSide";
            this.thirdSide.Size = new System.Drawing.Size(89, 22);
            this.thirdSide.TabIndex = 2;
            this.thirdSide.TextChanged += new System.EventHandler(this.thirdSide_TextChanged);
            this.thirdSide.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.number_Check);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(66, 203);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(130, 17);
            this.label1.TabIndex = 3;
            this.label1.Text = "Тип треугольника:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 53);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(119, 17);
            this.label2.TabIndex = 5;
            this.label2.Text = "Первая сторона:";
            // 
            // labelSecond
            // 
            this.labelSecond.AutoSize = true;
            this.labelSecond.Location = new System.Drawing.Point(12, 97);
            this.labelSecond.Name = "labelSecond";
            this.labelSecond.Size = new System.Drawing.Size(118, 17);
            this.labelSecond.TabIndex = 6;
            this.labelSecond.Text = "Вторая сторона:";
            // 
            // labelThird
            // 
            this.labelThird.AutoSize = true;
            this.labelThird.Location = new System.Drawing.Point(12, 144);
            this.labelThird.Name = "labelThird";
            this.labelThird.Size = new System.Drawing.Size(117, 17);
            this.labelThird.TabIndex = 7;
            this.labelThird.Text = "Третья сторона:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(66, 235);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(20, 17);
            this.label6.TabIndex = 9;
            this.label6.Text = "...";
            // 
            // calculateButton
            // 
            this.calculateButton.Location = new System.Drawing.Point(69, 282);
            this.calculateButton.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.calculateButton.Name = "calculateButton";
            this.calculateButton.Size = new System.Drawing.Size(128, 27);
            this.calculateButton.TabIndex = 10;
            this.calculateButton.Text = "Рассчитать";
            this.calculateButton.UseVisualStyleBackColor = true;
            this.calculateButton.Click += new System.EventHandler(this.CalculateButtonTapped);
            // 
            // toolStrip1
            // 
            this.toolStrip1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.toolStrip1.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.clearStripButton,
            this.toolStripSeparator1,
            this.infoStripButton,
            this.toolStripSeparator2});
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(278, 27);
            this.toolStrip1.TabIndex = 11;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // clearStripButton
            // 
            this.clearStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
            this.clearStripButton.Image = ((System.Drawing.Image)(resources.GetObject("clearStripButton.Image")));
            this.clearStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.clearStripButton.Name = "clearStripButton";
            this.clearStripButton.Size = new System.Drawing.Size(115, 24);
            this.clearStripButton.Text = "Очистить поля";
            this.clearStripButton.Click += new System.EventHandler(this.clearStripButton_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 27);
            // 
            // infoStripButton
            // 
            this.infoStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
            this.infoStripButton.Image = ((System.Drawing.Image)(resources.GetObject("infoStripButton.Image")));
            this.infoStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.infoStripButton.Name = "infoStripButton";
            this.infoStripButton.Size = new System.Drawing.Size(108, 24);
            this.infoStripButton.Text = "О программе";
            this.infoStripButton.Click += new System.EventHandler(this.infoStripButton_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 27);
            // 
            // downloadButton
            // 
            this.downloadButton.Location = new System.Drawing.Point(136, 111);
            this.downloadButton.Name = "downloadButton";
            this.downloadButton.Size = new System.Drawing.Size(123, 30);
            this.downloadButton.TabIndex = 15;
            this.downloadButton.Text = "Загрузить";
            this.downloadButton.UseVisualStyleBackColor = true;
            this.downloadButton.Click += new System.EventHandler(this.downloadButton_Click);
            // 
            // Form1
            // 
            this.AcceptButton = this.calculateButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(278, 315);
            this.Controls.Add(this.downloadButton);
            this.Controls.Add(this.toolStrip1);
            this.Controls.Add(this.calculateButton);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.labelThird);
            this.Controls.Add(this.labelSecond);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.thirdSide);
            this.Controls.Add(this.secondSide);
            this.Controls.Add(this.firstSide);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Form1";
            this.Text = "Треугольники";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox firstSide;
        private System.Windows.Forms.TextBox secondSide;
        private System.Windows.Forms.TextBox thirdSide;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label labelSecond;
        private System.Windows.Forms.Label labelThird;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Button calculateButton;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripButton clearStripButton;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripButton infoStripButton;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.Button downloadButton;
    }
}

