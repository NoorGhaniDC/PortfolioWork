/* COSC2100 - Assignment 2
 * Noor Ghani, 100597372
 * October 13, 2024
 * Settings file to hold constants, variables, properties, and constructors.
 * */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Assignment2
{
    public class Settings
    {
        /// <summary>
        /// Variables and constants for grid.
        /// </summary>
        #region Class Scope Constants & Variables
        public const int GRID_SIZE = 10;
        public const int CELL_SIZE = 40;
        public const int TOTAL_BOATS = 5;

        public Button[,] gridButtons;

        public int remainingBoats;


        #endregion
        
        /// <summary>
        /// Properties for Comboboxes and ProgressBars.
        /// </summary>
        #region Properties
        public ProgressBar prgBSCarrier { get; set; }
        public ProgressBar prgBSBattleship { get; set; }
        public ProgressBar prgBSCruiser { get; set; }
        public ProgressBar prgBSSubmarine { get; set; }
        public ProgressBar prgBSDestroyer { get; set; }

        public ComboBox cboBSXCoordinates { get; set; }
        public ComboBox cboBSYCoordinates { get; set; }

        #endregion

        /// <summary>
        /// Constructor for ProgessBars and Comboboxes.
        /// </summary>
        /// <param name="prgCarrier"></param>
        /// <param name="prgBattleship"></param>
        /// <param name="prgCruiser"></param>
        /// <param name="prgSubmarine"></param>
        /// <param name="prgDestroyer"></param>
        /// <param name="xCoordinates"></param>
        /// <param name="yCoordinates"></param>
        #region Constructor
        public Settings(ProgressBar prgCarrier, ProgressBar prgBattleship, ProgressBar prgCruiser, ProgressBar prgSubmarine, ProgressBar prgDestroyer, ComboBox xCoordinates, ComboBox yCoordinates )
        {
            gridButtons = new Button[GRID_SIZE, GRID_SIZE];

            prgBSBattleship = prgBattleship;
            prgBSCarrier =  prgCarrier;
            prgBSCruiser = prgCruiser;
            prgBSSubmarine = prgSubmarine;
            prgBSDestroyer = prgDestroyer;
            cboBSXCoordinates = xCoordinates;
            cboBSYCoordinates = yCoordinates;

            InitializeComboBoxes();
        }

        public void InitializeProgressBars()
        {
            prgBSCarrier.Maximum = BS.GetBoatSize(BS.Boats.Carrier);
            prgBSCarrier.Value = prgBSCarrier.Maximum;

            prgBSBattleship.Maximum = BS.GetBoatSize(BS.Boats.Battleship);
            prgBSBattleship.Value = prgBSBattleship.Maximum;

            prgBSCruiser.Maximum = BS.GetBoatSize(BS.Boats.Cruiser);
            prgBSCruiser.Value = prgBSCruiser.Maximum;

            prgBSSubmarine.Maximum = BS.GetBoatSize(BS.Boats.Submarine);
            prgBSSubmarine.Value = prgBSSubmarine.Maximum;

            prgBSDestroyer.Maximum = BS.GetBoatSize(BS.Boats.Destroyer);
            prgBSDestroyer.Value = prgBSDestroyer.Maximum;

        }

        public void InitializeComboBoxes()
        {
            for (int i = 1; i <= GRID_SIZE; i++)
            {
                cboBSXCoordinates.Items.Add(i);
                cboBSYCoordinates.Items.Add(i);
            }

            cboBSXCoordinates.SelectedIndex = 0;
            cboBSYCoordinates.SelectedIndex = 0;
        }
        #endregion

    }

}
