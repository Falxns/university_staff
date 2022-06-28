namespace TriangleApp
{
    partial class MainForm
    {
        /// <summary>
        /// Обязательная переменная конструктора.
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
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.Clear1 = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.firstTextBox = new System.Windows.Forms.TextBox();
            this.secondTextBox = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.Clear2 = new System.Windows.Forms.Button();
            this.thirdTextBox = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.Clear3 = new System.Windows.Forms.Button();
            this.OkButton = new System.Windows.Forms.Button();
            this.ResultLabel = new System.Windows.Forms.Label();
            this.ClearAllButton = new System.Windows.Forms.Button();
            this.InfoButton = new System.Windows.Forms.Button();
            this.contextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.SuspendLayout();
            // 
            // Clear1
            // 
            this.Clear1.Enabled = false;
            this.Clear1.Location = new System.Drawing.Point(164, 64);
            this.Clear1.Name = "Clear1";
            this.Clear1.Size = new System.Drawing.Size(75, 23);
            this.Clear1.TabIndex = 1;
            this.Clear1.Text = "Очистить";
            this.Clear1.UseVisualStyleBackColor = true;
            this.Clear1.Click += new System.EventHandler(this.Clear1_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(28, 51);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(120, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Введите первое число";
            // 
            // firstTextBox
            // 
            this.firstTextBox.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.firstTextBox.ContextMenuStrip = this.contextMenuStrip1;
            this.firstTextBox.Location = new System.Drawing.Point(31, 67);
            this.firstTextBox.MaxLength = 8;
            this.firstTextBox.Name = "firstTextBox";
            this.firstTextBox.Size = new System.Drawing.Size(115, 20);
            this.firstTextBox.TabIndex = 2;
            this.firstTextBox.TextChanged += new System.EventHandler(this.firstTextBox_TextChanged);
            this.firstTextBox.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.firstTextBox_KeyPress);
            // 
            // secondTextBox
            // 
            this.secondTextBox.ContextMenuStrip = this.contextMenuStrip1;
            this.secondTextBox.Location = new System.Drawing.Point(31, 125);
            this.secondTextBox.MaxLength = 8;
            this.secondTextBox.Name = "secondTextBox";
            this.secondTextBox.Size = new System.Drawing.Size(115, 20);
            this.secondTextBox.TabIndex = 5;
            this.secondTextBox.TextChanged += new System.EventHandler(this.firstTextBox_TextChanged);
            this.secondTextBox.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.firstTextBox_KeyPress);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(28, 109);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(119, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "Введите второе число";
            // 
            // Clear2
            // 
            this.Clear2.Enabled = false;
            this.Clear2.Location = new System.Drawing.Point(164, 122);
            this.Clear2.Name = "Clear2";
            this.Clear2.Size = new System.Drawing.Size(75, 23);
            this.Clear2.TabIndex = 3;
            this.Clear2.Text = "Очистить";
            this.Clear2.UseVisualStyleBackColor = true;
            this.Clear2.Click += new System.EventHandler(this.Clear2_Click);
            // 
            // thirdTextBox
            // 
            this.thirdTextBox.ContextMenuStrip = this.contextMenuStrip1;
            this.thirdTextBox.Location = new System.Drawing.Point(31, 184);
            this.thirdTextBox.MaxLength = 8;
            this.thirdTextBox.Name = "thirdTextBox";
            this.thirdTextBox.Size = new System.Drawing.Size(115, 20);
            this.thirdTextBox.TabIndex = 8;
            this.thirdTextBox.TextChanged += new System.EventHandler(this.firstTextBox_TextChanged);
            this.thirdTextBox.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.firstTextBox_KeyPress);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(28, 168);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(118, 13);
            this.label3.TabIndex = 7;
            this.label3.Text = "Введите третье число";
            // 
            // Clear3
            // 
            this.Clear3.Enabled = false;
            this.Clear3.Location = new System.Drawing.Point(164, 181);
            this.Clear3.Name = "Clear3";
            this.Clear3.Size = new System.Drawing.Size(75, 23);
            this.Clear3.TabIndex = 6;
            this.Clear3.Text = "Очистить";
            this.Clear3.UseVisualStyleBackColor = true;
            this.Clear3.Click += new System.EventHandler(this.Clear3_Click);
            // 
            // OkButton
            // 
            this.OkButton.Enabled = false;
            this.OkButton.Location = new System.Drawing.Point(31, 225);
            this.OkButton.Name = "OkButton";
            this.OkButton.Size = new System.Drawing.Size(117, 44);
            this.OkButton.TabIndex = 9;
            this.OkButton.Text = "Определить тип треугольника";
            this.OkButton.UseVisualStyleBackColor = true;
            this.OkButton.Click += new System.EventHandler(this.OkButton_Click);
            // 
            // ResultLabel
            // 
            this.ResultLabel.AutoSize = true;
            this.ResultLabel.Location = new System.Drawing.Point(69, 291);
            this.ResultLabel.Name = "ResultLabel";
            this.ResultLabel.Size = new System.Drawing.Size(0, 13);
            this.ResultLabel.TabIndex = 10;
            // 
            // ClearAllButton
            // 
            this.ClearAllButton.Enabled = false;
            this.ClearAllButton.Location = new System.Drawing.Point(164, 225);
            this.ClearAllButton.Name = "ClearAllButton";
            this.ClearAllButton.Size = new System.Drawing.Size(75, 44);
            this.ClearAllButton.TabIndex = 11;
            this.ClearAllButton.Text = "Очистить все поля";
            this.ClearAllButton.UseVisualStyleBackColor = true;
            this.ClearAllButton.Click += new System.EventHandler(this.ClearAllButton_Click);
            // 
            // InfoButton
            // 
            this.InfoButton.Location = new System.Drawing.Point(72, 12);
            this.InfoButton.Name = "InfoButton";
            this.InfoButton.Size = new System.Drawing.Size(118, 23);
            this.InfoButton.TabIndex = 0;
            this.InfoButton.Text = "О программе";
            this.InfoButton.UseVisualStyleBackColor = true;
            this.InfoButton.Click += new System.EventHandler(this.InfoButton_Click);
            // 
            // contextMenuStrip1
            // 
            this.contextMenuStrip1.Enabled = false;
            this.contextMenuStrip1.Name = "contextMenuStrip1";
            this.contextMenuStrip1.Size = new System.Drawing.Size(61, 4);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(279, 281);
            this.Controls.Add(this.InfoButton);
            this.Controls.Add(this.ClearAllButton);
            this.Controls.Add(this.ResultLabel);
            this.Controls.Add(this.OkButton);
            this.Controls.Add(this.thirdTextBox);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.Clear3);
            this.Controls.Add(this.secondTextBox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.Clear2);
            this.Controls.Add(this.firstTextBox);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.Clear1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Задача о треугольнике";
            this.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.MainForm_KeyPress);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button Clear1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox firstTextBox;
        private System.Windows.Forms.TextBox secondTextBox;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button Clear2;
        private System.Windows.Forms.TextBox thirdTextBox;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button Clear3;
        private System.Windows.Forms.Button OkButton;
        private System.Windows.Forms.Label ResultLabel;
        private System.Windows.Forms.Button ClearAllButton;
        private System.Windows.Forms.Button InfoButton;
        private System.Windows.Forms.ContextMenuStrip contextMenuStrip1;
    }
}

