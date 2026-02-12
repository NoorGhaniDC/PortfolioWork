namespace Assignment2
{
    partial class frmMain
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
            this.components = new System.ComponentModel.Container();
            this.panBSGrid = new System.Windows.Forms.Panel();
            this.btnBSStartGame = new System.Windows.Forms.Button();
            this.btnBSResetGame = new System.Windows.Forms.Button();
            this.btnBSExit = new System.Windows.Forms.Button();
            this.lblBSHitOrMiss = new System.Windows.Forms.Label();
            this.prgBSCarrier = new System.Windows.Forms.ProgressBar();
            this.prgBSBattleship = new System.Windows.Forms.ProgressBar();
            this.prgBSCruiser = new System.Windows.Forms.ProgressBar();
            this.prgBSSubmarine = new System.Windows.Forms.ProgressBar();
            this.prgBSDestroyer = new System.Windows.Forms.ProgressBar();
            this.grbBSBoatStatus = new System.Windows.Forms.GroupBox();
            this.lblBSDestroyer = new System.Windows.Forms.Label();
            this.lblBSSubmarine = new System.Windows.Forms.Label();
            this.lblBSCruiser = new System.Windows.Forms.Label();
            this.lblBSBattleship = new System.Windows.Forms.Label();
            this.lblBSCarrier = new System.Windows.Forms.Label();
            this.nudBSNumberOfMissiles = new System.Windows.Forms.NumericUpDown();
            this.lblBSMissilesFired = new System.Windows.Forms.Label();
            this.cboBSXCoordinates = new System.Windows.Forms.ComboBox();
            this.cboBSYCoordinates = new System.Windows.Forms.ComboBox();
            this.btnBSFire = new System.Windows.Forms.Button();
            this.lblBSXCoordinate = new System.Windows.Forms.Label();
            this.lblYCoordinate = new System.Windows.Forms.Label();
            this.lblBSTitle = new System.Windows.Forms.Label();
            this.btnBSShowBoats = new System.Windows.Forms.Button();
            this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
            this.grbBSBoatStatus.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudBSNumberOfMissiles)).BeginInit();
            this.SuspendLayout();
            // 
            // panBSGrid
            // 
            this.panBSGrid.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.panBSGrid.AutoSize = true;
            this.panBSGrid.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panBSGrid.Location = new System.Drawing.Point(18, 12);
            this.panBSGrid.Name = "panBSGrid";
            this.panBSGrid.Size = new System.Drawing.Size(534, 492);
            this.panBSGrid.TabIndex = 0;
            // 
            // btnBSStartGame
            // 
            this.btnBSStartGame.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.btnBSStartGame.Location = new System.Drawing.Point(620, 655);
            this.btnBSStartGame.Name = "btnBSStartGame";
            this.btnBSStartGame.Size = new System.Drawing.Size(396, 50);
            this.btnBSStartGame.TabIndex = 1;
            this.btnBSStartGame.Text = "&Start Game";
            this.toolTip1.SetToolTip(this.btnBSStartGame, "Click to Start (alt+s)");
            this.btnBSStartGame.UseVisualStyleBackColor = true;
            this.btnBSStartGame.Click += new System.EventHandler(this.btnBSStartGame_Click);
            // 
            // btnBSResetGame
            // 
            this.btnBSResetGame.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.btnBSResetGame.Location = new System.Drawing.Point(620, 543);
            this.btnBSResetGame.Name = "btnBSResetGame";
            this.btnBSResetGame.Size = new System.Drawing.Size(396, 50);
            this.btnBSResetGame.TabIndex = 5;
            this.btnBSResetGame.Text = "&Reset Game";
            this.toolTip1.SetToolTip(this.btnBSResetGame, "Click to Reset (alt+r)");
            this.btnBSResetGame.UseVisualStyleBackColor = true;
            this.btnBSResetGame.Click += new System.EventHandler(this.btnBSResetGame_Click);
            // 
            // btnBSExit
            // 
            this.btnBSExit.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.btnBSExit.Location = new System.Drawing.Point(620, 599);
            this.btnBSExit.Name = "btnBSExit";
            this.btnBSExit.Size = new System.Drawing.Size(396, 50);
            this.btnBSExit.TabIndex = 7;
            this.btnBSExit.Text = "&Exit";
            this.toolTip1.SetToolTip(this.btnBSExit, "Click to Exit (alt+e)");
            this.btnBSExit.UseVisualStyleBackColor = true;
            this.btnBSExit.Click += new System.EventHandler(this.btnBSExit_Click);
            // 
            // lblBSHitOrMiss
            // 
            this.lblBSHitOrMiss.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.lblBSHitOrMiss.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblBSHitOrMiss.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBSHitOrMiss.Location = new System.Drawing.Point(18, 554);
            this.lblBSHitOrMiss.Name = "lblBSHitOrMiss";
            this.lblBSHitOrMiss.Size = new System.Drawing.Size(539, 183);
            this.lblBSHitOrMiss.TabIndex = 4;
            this.lblBSHitOrMiss.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // prgBSCarrier
            // 
            this.prgBSCarrier.BackColor = System.Drawing.SystemColors.Control;
            this.prgBSCarrier.Location = new System.Drawing.Point(185, 51);
            this.prgBSCarrier.Name = "prgBSCarrier";
            this.prgBSCarrier.Size = new System.Drawing.Size(258, 35);
            this.prgBSCarrier.TabIndex = 5;
            // 
            // prgBSBattleship
            // 
            this.prgBSBattleship.BackColor = System.Drawing.SystemColors.Control;
            this.prgBSBattleship.Location = new System.Drawing.Point(185, 89);
            this.prgBSBattleship.Name = "prgBSBattleship";
            this.prgBSBattleship.Size = new System.Drawing.Size(258, 35);
            this.prgBSBattleship.TabIndex = 6;
            // 
            // prgBSCruiser
            // 
            this.prgBSCruiser.BackColor = System.Drawing.SystemColors.Control;
            this.prgBSCruiser.Location = new System.Drawing.Point(185, 130);
            this.prgBSCruiser.Name = "prgBSCruiser";
            this.prgBSCruiser.Size = new System.Drawing.Size(258, 35);
            this.prgBSCruiser.TabIndex = 7;
            // 
            // prgBSSubmarine
            // 
            this.prgBSSubmarine.BackColor = System.Drawing.SystemColors.Control;
            this.prgBSSubmarine.Location = new System.Drawing.Point(185, 168);
            this.prgBSSubmarine.Name = "prgBSSubmarine";
            this.prgBSSubmarine.Size = new System.Drawing.Size(258, 35);
            this.prgBSSubmarine.TabIndex = 8;
            // 
            // prgBSDestroyer
            // 
            this.prgBSDestroyer.BackColor = System.Drawing.SystemColors.Control;
            this.prgBSDestroyer.Location = new System.Drawing.Point(185, 209);
            this.prgBSDestroyer.Name = "prgBSDestroyer";
            this.prgBSDestroyer.Size = new System.Drawing.Size(258, 35);
            this.prgBSDestroyer.TabIndex = 9;
            // 
            // grbBSBoatStatus
            // 
            this.grbBSBoatStatus.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.grbBSBoatStatus.Controls.Add(this.lblBSDestroyer);
            this.grbBSBoatStatus.Controls.Add(this.lblBSSubmarine);
            this.grbBSBoatStatus.Controls.Add(this.lblBSCruiser);
            this.grbBSBoatStatus.Controls.Add(this.lblBSBattleship);
            this.grbBSBoatStatus.Controls.Add(this.lblBSCarrier);
            this.grbBSBoatStatus.Controls.Add(this.prgBSCarrier);
            this.grbBSBoatStatus.Controls.Add(this.prgBSDestroyer);
            this.grbBSBoatStatus.Controls.Add(this.prgBSBattleship);
            this.grbBSBoatStatus.Controls.Add(this.prgBSSubmarine);
            this.grbBSBoatStatus.Controls.Add(this.prgBSCruiser);
            this.grbBSBoatStatus.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grbBSBoatStatus.Location = new System.Drawing.Point(585, 118);
            this.grbBSBoatStatus.Name = "grbBSBoatStatus";
            this.grbBSBoatStatus.Size = new System.Drawing.Size(453, 261);
            this.grbBSBoatStatus.TabIndex = 10;
            this.grbBSBoatStatus.TabStop = false;
            this.grbBSBoatStatus.Text = "Boat Status";
            // 
            // lblBSDestroyer
            // 
            this.lblBSDestroyer.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBSDestroyer.Location = new System.Drawing.Point(8, 209);
            this.lblBSDestroyer.Name = "lblBSDestroyer";
            this.lblBSDestroyer.Size = new System.Drawing.Size(171, 35);
            this.lblBSDestroyer.TabIndex = 14;
            this.lblBSDestroyer.Text = "Destroyer (2)";
            this.lblBSDestroyer.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblBSSubmarine
            // 
            this.lblBSSubmarine.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBSSubmarine.ImageAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.lblBSSubmarine.Location = new System.Drawing.Point(7, 168);
            this.lblBSSubmarine.Name = "lblBSSubmarine";
            this.lblBSSubmarine.Size = new System.Drawing.Size(171, 35);
            this.lblBSSubmarine.TabIndex = 13;
            this.lblBSSubmarine.Text = "Submarine (3)";
            this.lblBSSubmarine.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblBSCruiser
            // 
            this.lblBSCruiser.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBSCruiser.Location = new System.Drawing.Point(6, 130);
            this.lblBSCruiser.Name = "lblBSCruiser";
            this.lblBSCruiser.Size = new System.Drawing.Size(171, 35);
            this.lblBSCruiser.TabIndex = 12;
            this.lblBSCruiser.Text = "Cruiser (3)";
            this.lblBSCruiser.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblBSBattleship
            // 
            this.lblBSBattleship.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBSBattleship.Location = new System.Drawing.Point(8, 89);
            this.lblBSBattleship.Name = "lblBSBattleship";
            this.lblBSBattleship.Size = new System.Drawing.Size(171, 35);
            this.lblBSBattleship.TabIndex = 11;
            this.lblBSBattleship.Text = "Battleship (4)";
            this.lblBSBattleship.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblBSCarrier
            // 
            this.lblBSCarrier.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBSCarrier.Location = new System.Drawing.Point(8, 51);
            this.lblBSCarrier.Name = "lblBSCarrier";
            this.lblBSCarrier.Size = new System.Drawing.Size(171, 35);
            this.lblBSCarrier.TabIndex = 10;
            this.lblBSCarrier.Text = "Carrier (5)";
            this.lblBSCarrier.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // nudBSNumberOfMissiles
            // 
            this.nudBSNumberOfMissiles.Enabled = false;
            this.nudBSNumberOfMissiles.Location = new System.Drawing.Point(620, 446);
            this.nudBSNumberOfMissiles.Name = "nudBSNumberOfMissiles";
            this.nudBSNumberOfMissiles.ReadOnly = true;
            this.nudBSNumberOfMissiles.Size = new System.Drawing.Size(117, 22);
            this.nudBSNumberOfMissiles.TabIndex = 15;
            this.toolTip1.SetToolTip(this.nudBSNumberOfMissiles, "Missles Fired");
            // 
            // lblBSMissilesFired
            // 
            this.lblBSMissilesFired.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBSMissilesFired.Location = new System.Drawing.Point(577, 404);
            this.lblBSMissilesFired.Name = "lblBSMissilesFired";
            this.lblBSMissilesFired.Size = new System.Drawing.Size(206, 35);
            this.lblBSMissilesFired.TabIndex = 16;
            this.lblBSMissilesFired.Text = "Missiles Fired";
            this.lblBSMissilesFired.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // cboBSXCoordinates
            // 
            this.cboBSXCoordinates.FormattingEnabled = true;
            this.cboBSXCoordinates.Location = new System.Drawing.Point(854, 446);
            this.cboBSXCoordinates.Name = "cboBSXCoordinates";
            this.cboBSXCoordinates.Size = new System.Drawing.Size(157, 24);
            this.cboBSXCoordinates.TabIndex = 2;
            this.toolTip1.SetToolTip(this.cboBSXCoordinates, "Select X Coordinate");
            // 
            // cboBSYCoordinates
            // 
            this.cboBSYCoordinates.FormattingEnabled = true;
            this.cboBSYCoordinates.Location = new System.Drawing.Point(854, 409);
            this.cboBSYCoordinates.Name = "cboBSYCoordinates";
            this.cboBSYCoordinates.Size = new System.Drawing.Size(157, 24);
            this.cboBSYCoordinates.TabIndex = 3;
            this.toolTip1.SetToolTip(this.cboBSYCoordinates, "Select Y Coordinate");
            // 
            // btnBSFire
            // 
            this.btnBSFire.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.btnBSFire.Location = new System.Drawing.Point(620, 487);
            this.btnBSFire.Name = "btnBSFire";
            this.btnBSFire.Size = new System.Drawing.Size(396, 50);
            this.btnBSFire.TabIndex = 4;
            this.btnBSFire.Text = "&Fire!";
            this.toolTip1.SetToolTip(this.btnBSFire, "Click to Fire (alt+f)");
            this.btnBSFire.UseVisualStyleBackColor = true;
            this.btnBSFire.Click += new System.EventHandler(this.btnBSFire_Click);
            // 
            // lblBSXCoordinate
            // 
            this.lblBSXCoordinate.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBSXCoordinate.Location = new System.Drawing.Point(801, 410);
            this.lblBSXCoordinate.Name = "lblBSXCoordinate";
            this.lblBSXCoordinate.Size = new System.Drawing.Size(47, 23);
            this.lblBSXCoordinate.TabIndex = 14;
            this.lblBSXCoordinate.Text = "X :";
            // 
            // lblYCoordinate
            // 
            this.lblYCoordinate.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblYCoordinate.Location = new System.Drawing.Point(801, 447);
            this.lblYCoordinate.Name = "lblYCoordinate";
            this.lblYCoordinate.Size = new System.Drawing.Size(47, 23);
            this.lblYCoordinate.TabIndex = 15;
            this.lblYCoordinate.Text = "Y :";
            // 
            // lblBSTitle
            // 
            this.lblBSTitle.Font = new System.Drawing.Font("Microsoft Sans Serif", 16.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBSTitle.Location = new System.Drawing.Point(563, 24);
            this.lblBSTitle.Name = "lblBSTitle";
            this.lblBSTitle.Size = new System.Drawing.Size(453, 65);
            this.lblBSTitle.TabIndex = 17;
            this.lblBSTitle.Text = "Battleship";
            this.lblBSTitle.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // btnBSShowBoats
            // 
            this.btnBSShowBoats.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.btnBSShowBoats.Location = new System.Drawing.Point(620, 711);
            this.btnBSShowBoats.Name = "btnBSShowBoats";
            this.btnBSShowBoats.Size = new System.Drawing.Size(396, 50);
            this.btnBSShowBoats.TabIndex = 6;
            this.btnBSShowBoats.Text = "S&how Boats";
            this.toolTip1.SetToolTip(this.btnBSShowBoats, "Click to Show Boats (alt+h)");
            this.btnBSShowBoats.UseVisualStyleBackColor = true;
            this.btnBSShowBoats.Click += new System.EventHandler(this.btnBSShowBoats_Click);
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.Control;
            this.ClientSize = new System.Drawing.Size(1050, 763);
            this.Controls.Add(this.btnBSShowBoats);
            this.Controls.Add(this.lblBSTitle);
            this.Controls.Add(this.nudBSNumberOfMissiles);
            this.Controls.Add(this.lblBSMissilesFired);
            this.Controls.Add(this.lblYCoordinate);
            this.Controls.Add(this.lblBSXCoordinate);
            this.Controls.Add(this.btnBSFire);
            this.Controls.Add(this.cboBSYCoordinates);
            this.Controls.Add(this.cboBSXCoordinates);
            this.Controls.Add(this.panBSGrid);
            this.Controls.Add(this.grbBSBoatStatus);
            this.Controls.Add(this.lblBSHitOrMiss);
            this.Controls.Add(this.btnBSExit);
            this.Controls.Add(this.btnBSResetGame);
            this.Controls.Add(this.btnBSStartGame);
            this.MaximumSize = new System.Drawing.Size(1068, 810);
            this.MinimumSize = new System.Drawing.Size(1068, 810);
            this.Name = "frmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Battleship";
            this.grbBSBoatStatus.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.nudBSNumberOfMissiles)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panBSGrid;
        private System.Windows.Forms.Button btnBSStartGame;
        private System.Windows.Forms.Button btnBSResetGame;
        private System.Windows.Forms.Button btnBSExit;
        private System.Windows.Forms.Label lblBSHitOrMiss;
        private System.Windows.Forms.ProgressBar prgBSCarrier;
        private System.Windows.Forms.ProgressBar prgBSBattleship;
        private System.Windows.Forms.ProgressBar prgBSCruiser;
        private System.Windows.Forms.ProgressBar prgBSSubmarine;
        private System.Windows.Forms.ProgressBar prgBSDestroyer;
        private System.Windows.Forms.GroupBox grbBSBoatStatus;
        private System.Windows.Forms.Label lblBSDestroyer;
        private System.Windows.Forms.Label lblBSSubmarine;
        private System.Windows.Forms.Label lblBSCruiser;
        private System.Windows.Forms.Label lblBSBattleship;
        private System.Windows.Forms.Label lblBSCarrier;
        private System.Windows.Forms.Label lblBSMissilesFired;
        private System.Windows.Forms.ComboBox cboBSXCoordinates;
        private System.Windows.Forms.ComboBox cboBSYCoordinates;
        private System.Windows.Forms.Button btnBSFire;
        private System.Windows.Forms.Label lblBSXCoordinate;
        private System.Windows.Forms.Label lblYCoordinate;
        private System.Windows.Forms.Label lblBSTitle;
        private System.Windows.Forms.NumericUpDown nudBSNumberOfMissiles;
        private System.Windows.Forms.Button btnBSShowBoats;
        private System.Windows.Forms.ToolTip toolTip1;
    }
}

