/* COSC2100 - Assignment 2
 * Noor Ghani, 100597372
 * October 13, 2024
 * The main form code file for the Battleship Game.
 * */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Text;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Media;

namespace Assignment2
{
    public partial class frmMain : Form
    {
        #region Startup 
        /// <summary>
        /// Declared a private member variable within 
        /// frmMain class that holds an instance
        /// of the settings class.
        /// </summary>
        private Settings settings;
        /// <summary>
        /// Initializes Component and Sets Defaults.
        /// </summary>
        ///
        public frmMain()
        {
            InitializeComponent();
            SetDefaults();
        }
        /// <summary>
        /// Defaults.
        /// </summary>
        public void SetDefaults()
        {
            settings = new Settings(prgBSCarrier, prgBSBattleship, prgBSCruiser, prgBSSubmarine, prgBSDestroyer, cboBSXCoordinates, cboBSYCoordinates);
            btnBSResetGame.Enabled = false;
            btnBSFire.Enabled = false;
            btnBSShowBoats.Enabled = false;
            this.KeyDown += new KeyEventHandler(Form_KeyDown);
            this.KeyPreview = true;
            lblBSHitOrMiss.Text = "Press Start to Play...";
        }
        #endregion

        #region Custom Methods
        /// <summary>
        /// Initialize the player grid within the panel.
        /// </summary>
        private void InitializeGrid()
        {
            BS.RandomizeBoats();
            panBSGrid.Width = Settings.CELL_SIZE * Settings.GRID_SIZE;
            panBSGrid.Height = Settings.CELL_SIZE*Settings.GRID_SIZE;
            panBSGrid.BackColor = Color.LightGray;

            for (int row = 0 ; row < Settings.GRID_SIZE ; row++)
            {
                for (int col = 0 ; col < Settings.GRID_SIZE ; col++)
                {
                    Button gridBSButton = new Button
                    {
                        Width = Settings.CELL_SIZE,
                        Height = Settings.CELL_SIZE,
                        Location = new Point(col*Settings.CELL_SIZE, row*Settings.CELL_SIZE),
                        Tag = new Point(row, col),
                        BackColor = Color.White,

                        Text = $"Y{col + 1}, X{row+1}",
                        Font = new Font(FontFamily.GenericSerif, 8, FontStyle.Regular),
                    };

                    gridBSButton.Click += new EventHandler(BSGridButton_Click);

                    panBSGrid.Controls.Add(gridBSButton);
                    settings.gridButtons[row, col] = gridBSButton;
                }
            }
        }
        /// <summary>
        /// Handles the click event for the buttons in the panel.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BSGridButton_Click(object sender, EventArgs e)
        {
            Button clicked = sender as Button;
            Point coordinates = (Point)clicked.Tag;
            int row = (int)coordinates.X;
            int col = (int)coordinates.Y;

            MissileStrikeAt(row, col);
        }
        /// <summary>
        /// Handles the event for the fire button.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnBSFire_Click(object sender, EventArgs e)
        {
            if(!btnBSFire.Enabled) return;
            if (cboBSXCoordinates.SelectedItem == null || cboBSYCoordinates.SelectedItem == null)
            {
                return;
            }

            int col = (int)cboBSXCoordinates.SelectedItem -1;
            int row = (int)cboBSYCoordinates.SelectedItem - 1;

            MissileStrikeAt(row, col);
        }
        /// <summary>
        /// Method for seeing if strike landed, missed, or to alert if the target has been hit already.
        /// </summary>
        /// <param name="row"></param>
        /// <param name="col"></param>
        private void MissileStrikeAt(int row, int col)
        {
            if (BS.board[row + 1, col + 1] == BS.BoardStatus.Hit ||
                BS.board[row + 1, col + 1] == BS.BoardStatus.Miss)
            {
                lblBSHitOrMiss.Text = "Square has been hit already..." +
                    "Try another!";
                lblBSHitOrMiss.ForeColor = Color.Black;
                return;
            }

            var boatHit = BS.boatPositions[row + 1, col + 1];

            if (boatHit != BS.Boats.NoBoat)
            {
                settings.gridButtons[row, col].BackColor = Color.Red;
                BS.board[row + 1, col + 1] = BS.BoardStatus.Hit;
                lblBSHitOrMiss.Text = "Hit!";
                lblBSHitOrMiss.ForeColor = Color.Red;
                SoundPlayer player = new SoundPlayer("Something being hit - Sound Effect.wav");
                player.Play();
                UpdateProgressBars();
            }
            else
            {
                settings.gridButtons[row, col].BackColor = Color.LightBlue;
                BS.board[row + 1, col + 1] = BS.BoardStatus.Miss;
                lblBSHitOrMiss.Text = "Miss...";
                lblBSHitOrMiss.ForeColor = Color.Blue;
                SoundPlayer player = new SoundPlayer("Nope sound effect.wav");
                player.Play();
            }

            nudBSNumberOfMissiles.Value += 1;
        }
        /// <summary>
        /// Method for the progress bars of the boats.
        /// </summary>
        private void UpdateProgressBars()
        {
            bool allBoatsSunk = true;

            foreach (BS.Boats boat in Enum.GetValues(typeof(BS.Boats)))
            {
                int boatSize = BS.GetBoatSize(boat);
                int hits = 0;

                for (int row = 1; row <= BS.MAX_BOARD_SIZE; row++)
                {
                    for (int col =1; col <= BS.MAX_BOARD_SIZE; col++)
                    {
                        if (BS.boatPositions[row, col] == boat && BS.board[row, col] == BS.BoardStatus.Hit)
                        {
                            hits++;
                        }
                    }
                }

                int remainingHealth = boatSize - hits;
                remainingHealth = Math.Max(0, remainingHealth);

                switch (boat)
                {
                    case BS.Boats.Carrier:
                        settings.prgBSCarrier.Maximum = boatSize;
                        settings.prgBSCarrier.Value = remainingHealth;
                        settings.prgBSCarrier.BackColor = remainingHealth > 0 ? Color.Green : Color.Red;
                        break;
                    case BS.Boats.Battleship:
                        settings.prgBSBattleship.Maximum = boatSize;
                        settings.prgBSBattleship.Value = remainingHealth;
                        settings.prgBSBattleship.BackColor = remainingHealth > 0 ? Color.Green :Color.Red;
                        break;
                    case BS.Boats.Cruiser:
                        settings.prgBSCruiser.Maximum = boatSize;
                        settings.prgBSCruiser.Value = remainingHealth;
                        settings.prgBSCruiser.BackColor = remainingHealth > 0 ? Color.Green :Color.Red;
                        break;
                    case BS.Boats.Submarine:
                        settings.prgBSSubmarine.Maximum = boatSize;
                        settings.prgBSSubmarine.Value = remainingHealth;
                        settings.prgBSSubmarine.BackColor = remainingHealth > 0 ? Color.Green : Color.Red;
                        break;
                    case BS.Boats.Destroyer:
                        settings.prgBSDestroyer.Maximum = boatSize;
                        settings.prgBSDestroyer.Value = remainingHealth;
                        settings.prgBSDestroyer.BackColor = remainingHealth > 0 ? Color.Green : Color.Red;
                        break;
                }

                if (remainingHealth > 0)
                {
                    allBoatsSunk = false;
                }
            }

            if (allBoatsSunk)
            {
                SoundPlayer player = new SoundPlayer("Microsoft Windows 3.1 Startup Sound.wav");
                player.Play();
                lblBSHitOrMiss.Text = "All Boats are Destroyed. You Win!!";
                lblBSHitOrMiss.ForeColor = Color.ForestGreen;
                btnBSFire.Enabled = false;
                cboBSXCoordinates.Enabled = false;
                cboBSYCoordinates.Enabled = false;

                foreach (Button gridButton in settings.gridButtons)
                {
                    gridButton.Enabled = false;
                }
            }
        }
        #endregion

        #region General Events
        /// <summary>
        /// Handles the events for the reset button.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnBSResetGame_Click(object sender, EventArgs e)
        {
            btnBSFire.Enabled = true;
            btnBSShowBoats.Enabled = true;
            cboBSXCoordinates.Enabled = true;
            cboBSYCoordinates.Enabled = true;

            foreach (Button gridButton in settings.gridButtons)
            {
                gridButton.Enabled = true;
            }

            for (int row = 0; row < Settings.GRID_SIZE; row++)
            {
                for (int col = 0; col < Settings.GRID_SIZE; col++)
                {
                    BS.board[row + 1, col + 1] = BS.BoardStatus.Empty;
                    BS.boatPositions[row + 1, col + 1] = BS.Boats.NoBoat;
                    settings.gridButtons[row, col].BackColor = Color.White;
                }
            }

            BS.RandomizeBoats();
            settings.InitializeProgressBars();
            lblBSHitOrMiss.Text = "New Game. Select Where to Fire Missile.";
            lblBSHitOrMiss.ForeColor = Color.Black;
            nudBSNumberOfMissiles.Value = 0;
            cboBSXCoordinates.SelectedIndex = 0;
            cboBSYCoordinates.SelectedIndex = 0;
        }
        /// <summary>
        /// The Key Event Handler for the Escape Button to Leave Program.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Form_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Escape)

                {if (MessageBox.Show("Are you sure you want to exit?", "Exit Confirmation", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    Application.Exit();
                }
                   
            }
        }
       /// <summary>
       /// Handles the exit button.
       /// </summary>
       /// <param name="sender"></param>
       /// <param name="e"></param>
        private void btnBSExit_Click(object sender, EventArgs e)
        {
            {
                if (MessageBox.Show("Are you sure you want to exit?", "Exit Confirmation", MessageBoxButtons.YesNo) == DialogResult.Yes)
                    Application.Exit();
            }
        }
        /// <summary>
        /// Handles the Start Button.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnBSStartGame_Click(object sender, EventArgs e)
        {            
            InitializeGrid();
            settings.InitializeProgressBars();
            btnBSResetGame.Enabled = true;
            btnBSStartGame.Enabled = false;
            btnBSShowBoats.Enabled = true;
            lblBSHitOrMiss.Text = string.Empty;
            btnBSFire.Enabled = true;
            cboBSXCoordinates.Enabled = true;
            cboBSYCoordinates.Enabled = true;
            cboBSXCoordinates.SelectedIndex = 0;
            cboBSYCoordinates.SelectedIndex = 0;
            lblBSHitOrMiss.Text = "Game Started. Select where to fire missile.";

        }
        /// <summary>
        /// Handles the Show Boats Button.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnBSShowBoats_Click(object sender, EventArgs e)
        {
            btnBSShowBoats.Enabled = false;
            {
                for (int row = 0; row < Settings.GRID_SIZE; row++)
                {
                    for (int col = 0; col < Settings.GRID_SIZE; col++)
                    {
                        if (BS.boatPositions[row + 1, col + 1] != BS.Boats.NoBoat)
                        {
                            if (settings.gridButtons[row,col].BackColor != Color.Red)
                            {
                                settings.gridButtons[row, col].BackColor = Color.Orange;
                            }
                        }
                    }
                }
            }
        }
        #endregion

    }
}
