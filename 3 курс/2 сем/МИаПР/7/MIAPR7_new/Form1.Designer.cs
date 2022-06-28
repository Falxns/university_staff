namespace MiAPR_7
{
    partial class Form1
    {
        /// <summary>
        /// Требуется переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Обязательный метод для поддержки конструктора - не изменяйте
        /// содержимое данного метода при помощи редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.comboBox_Primitives = new System.Windows.Forms.ComboBox();
            this.pictureBox_Man = new System.Windows.Forms.PictureBox();
            this.button_Clear = new System.Windows.Forms.Button();
            this.button_Analysis = new System.Windows.Forms.Button();
            this.label_Primitives = new System.Windows.Forms.Label();
            this.radioButton1 = new System.Windows.Forms.RadioButton();
            this.radioButton2 = new System.Windows.Forms.RadioButton();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_Man)).BeginInit();
            this.SuspendLayout();
            // 
            // comboBox_Primitives
            // 
            this.comboBox_Primitives.FormattingEnabled = true;
            this.comboBox_Primitives.Location = new System.Drawing.Point(842, 112);
            this.comboBox_Primitives.Name = "comboBox_Primitives";
            this.comboBox_Primitives.Size = new System.Drawing.Size(252, 41);
            this.comboBox_Primitives.TabIndex = 0;
            // 
            // pictureBox_Man
            // 
            this.pictureBox_Man.BackColor = System.Drawing.SystemColors.Window;
            this.pictureBox_Man.Location = new System.Drawing.Point(12, 12);
            this.pictureBox_Man.Name = "pictureBox_Man";
            this.pictureBox_Man.Size = new System.Drawing.Size(800, 600);
            this.pictureBox_Man.TabIndex = 1;
            this.pictureBox_Man.TabStop = false;
            this.pictureBox_Man.MouseDown += new System.Windows.Forms.MouseEventHandler(this.pictureBox_Man_MouseDown);
            // 
            // button_Clear
            // 
            this.button_Clear.BackColor = System.Drawing.Color.White;
            this.button_Clear.Font = new System.Drawing.Font("Georgia", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button_Clear.Location = new System.Drawing.Point(842, 359);
            this.button_Clear.Name = "button_Clear";
            this.button_Clear.Size = new System.Drawing.Size(266, 48);
            this.button_Clear.TabIndex = 2;
            this.button_Clear.Text = "Очистить поле";
            this.button_Clear.UseVisualStyleBackColor = false;
            this.button_Clear.Click += new System.EventHandler(this.button_Clear_Click);
            // 
            // button_Analysis
            // 
            this.button_Analysis.BackColor = System.Drawing.Color.White;
            this.button_Analysis.Font = new System.Drawing.Font("Georgia", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button_Analysis.ForeColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.button_Analysis.Location = new System.Drawing.Point(842, 282);
            this.button_Analysis.Name = "button_Analysis";
            this.button_Analysis.Size = new System.Drawing.Size(266, 48);
            this.button_Analysis.TabIndex = 3;
            this.button_Analysis.Text = "Анализ рисунка";
            this.button_Analysis.UseVisualStyleBackColor = false;
            this.button_Analysis.Click += new System.EventHandler(this.button_Analysis_Click);
            // 
            // label_Primitives
            // 
            this.label_Primitives.AutoSize = true;
            this.label_Primitives.Font = new System.Drawing.Font("Georgia", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label_Primitives.Location = new System.Drawing.Point(836, 59);
            this.label_Primitives.Name = "label_Primitives";
            this.label_Primitives.Size = new System.Drawing.Size(360, 35);
            this.label_Primitives.TabIndex = 4;
            this.label_Primitives.Text = "Терминальные объекты:";
            // 
            // radioButton1
            // 
            this.radioButton1.AutoSize = true;
            this.radioButton1.Checked = true;
            this.radioButton1.Font = new System.Drawing.Font("Georgia", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.radioButton1.Location = new System.Drawing.Point(847, 177);
            this.radioButton1.Name = "radioButton1";
            this.radioButton1.Size = new System.Drawing.Size(318, 33);
            this.radioButton1.TabIndex = 5;
            this.radioButton1.TabStop = true;
            this.radioButton1.Text = "Мороженое в левой руке";
            this.radioButton1.UseVisualStyleBackColor = true;
            // 
            // radioButton2
            // 
            this.radioButton2.AutoSize = true;
            this.radioButton2.Font = new System.Drawing.Font("Georgia", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radioButton2.Location = new System.Drawing.Point(847, 216);
            this.radioButton2.Name = "radioButton2";
            this.radioButton2.Size = new System.Drawing.Size(332, 33);
            this.radioButton2.TabIndex = 6;
            this.radioButton2.Text = "Мороженое в правой руке";
            this.radioButton2.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.BackColor = System.Drawing.Color.LavenderBlush;
            this.ClientSize = new System.Drawing.Size(1177, 627);
            this.Controls.Add(this.radioButton2);
            this.Controls.Add(this.radioButton1);
            this.Controls.Add(this.label_Primitives);
            this.Controls.Add(this.button_Analysis);
            this.Controls.Add(this.button_Clear);
            this.Controls.Add(this.pictureBox_Man);
            this.Controls.Add(this.comboBox_Primitives);
            this.Font = new System.Drawing.Font("Times New Roman", 14.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "СИНТЕЗ И РАСПОЗНАВАНИЕ ОБЪЕКТОВ";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_Man)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox comboBox_Primitives;
        private System.Windows.Forms.PictureBox pictureBox_Man;
        private System.Windows.Forms.Button button_Clear;
        private System.Windows.Forms.Button button_Analysis;
        private System.Windows.Forms.Label label_Primitives;
        private System.Windows.Forms.RadioButton radioButton1;
        private System.Windows.Forms.RadioButton radioButton2;
    }
}

