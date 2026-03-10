/* COSC2100 - Assignment 2
 * Noor Ghani, 100597372
 * October 13, 2024
 * Created initially by Prof. MacDonald and meant to be integerated by myself
 * into Assignnment 2. This class is used to randomize the placement of boats,
 * make sure the boats do not collide, get the size of the boats and various other functions.
 * */

using Assignment2;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;


/* ****************************************************************
 * 
 * Except for changing the below namespace
 * 
 * DO NO EDIT THIS FILE UNLESS PROFESSOR TELLS YOU TO UPDATE IT 
 * 
 * If you neeed to add things to this class, create a second file 
 * with the same namespace and same public static partial class BS 
 * declaration....  (research partial classes)
 * 
 *************************************************************** */

namespace Assignment2
{
    public static partial class BS
    {

        #region Constants, enums, and Game Variables

        // basic integer constants
        public static int
            MAX_BOARD_SIZE = 10;

        // an enum to represent the various statuses of the board squares
        public enum BoardStatus {
            Empty = 0,
            Miss = 1,
            Hit = 2
        };

        // an enum to represent the 4 cardination directions
        public enum Directions { East, South, West, North };

        // a 2D array representing the statuses of each square
        public static BoardStatus[,] board = new BoardStatus[MAX_BOARD_SIZE+1, MAX_BOARD_SIZE+1];

        // enum representing the boats       
        public enum Boats { NoBoat, Destroyer, Submarine, Cruiser, Battleship, Carrier};

        // a 2D array representing the positions of the boats
        public static Boats[,] boatPositions = new Boats[MAX_BOARD_SIZE + 1, MAX_BOARD_SIZE + 1];
        #endregion

        #region Place Boats

        /// <summary>
        /// Starting with no boats on the board, this will organize the placing of the 5 boats
        /// </summary>
        public static void RandomizeBoats()
        {
            PlaceBoat(Boats.Carrier);
            PlaceBoat(Boats.Battleship);
            PlaceBoat(Boats.Cruiser);
            PlaceBoat(Boats.Submarine);
            PlaceBoat(Boats.Destroyer);
        }

        /// <summary>
        /// Receives a boat and places it in a random location
        /// </summary>
        /// <param name="boat"></param>
        private static void PlaceBoat(Boats boat)
        {
            Boolean isOk = false;
            Directions dir;
            int
                x = 0,
                y = 0,
                size = GetBoatSize(boat); // gets boat size

            while (!isOk)
            {
                //randomize start point
                x = Tools.RandomInt(1, MAX_BOARD_SIZE + 1);
                y = Tools.RandomInt(1, MAX_BOARD_SIZE + 1);

                //randomize direction
                dir = (Directions)Tools.RandomInt(0, 4);

                // checks and placing of the boat
                if (IsOnboard(x,y,size,dir))  // check is boat contained within board size
                {
                    if (NoCollisions(x,y,size,dir))  // check if boat will collide with an already placed boat
                    {
                        PlaceBoat(x,y,size,dir,boat);
                        isOk = true;
                    }
                }
            };            

        }

        /// <summary>
        /// A check that sees if a random boat position will go off the screen!
        /// </summary>
        /// <param name="x"></param>
        /// <param name="y"></param>
        /// <param name="size"></param>
        /// <param name="dir"></param>
        /// <returns></returns>
        private static bool IsOnboard (int x, int y, int size, Directions dir)
        {
            bool onBoard = true;
            switch (dir)
            {
                case Directions.North:
                    // check if goes off top
                    if (y - size + 1 < 1) onBoard = false;
                    break;
                case Directions.South:
                    // check if goes off bottom
                    if (y + size - 1 > MAX_BOARD_SIZE) onBoard = false;
                    break;
                case Directions.East:
                    // check if goes off right
                    if (x + size - 1 > MAX_BOARD_SIZE) onBoard = false;
                    break;
                case Directions.West:
                    // check if goes off left
                    if (x - size + 1 < 1) onBoard = false;
                    break;
                default: onBoard = false; break;
            }

            return onBoard;
        }

        /// <summary>
        /// A check to see if a random boat position will collide with an already placed boat
        /// </summary>
        /// <param name="x"></param>
        /// <param name="y"></param>
        /// <param name="size"></param>
        /// <param name="dir"></param>
        /// <returns></returns>
        private static bool NoCollisions(int x, int y, int size, Directions dir)
        {
            bool noCollision = true;
            switch (dir)
            {
                case Directions.North:
                    // check if goes off top
                    for (int i = y - size + 1; i <= y; i++)
                    {
                        if (boatPositions[x, i] != Boats.NoBoat)
                        {
                            noCollision = false;
                            break;
                        }
                    }
                    break;
                case Directions.South:
                    // check if goes off bottom
                    for (int i = y; i < y + size; i++)
                    {
                        if (boatPositions[x, i] != Boats.NoBoat)
                        {
                            noCollision = false;
                            break;
                        }
                    }
                    break;
                case Directions.East:
                    // check if goes off right
                    for (int i = x; i < x + size; i++)
                    {
                        if (boatPositions[i, y] != Boats.NoBoat)
                        {
                            noCollision = false;
                            break;
                        }
                    }
                    break;
                case Directions.West:
                    // check if goes off left
                    for (int i = x - size + 1; i <= x; i++)
                    {
                        if (boatPositions[i, y] != Boats.NoBoat)
                        {
                            noCollision = false;
                            break;
                        }
                    }
                    break;
                default: noCollision = false; break;
            }

            return noCollision;
        }

        /// <summary>
        /// Places the boat in the location randomized (only run after all checks have passed)
        /// </summary>
        /// <param name="x"></param>
        /// <param name="y"></param>
        /// <param name="size"></param>
        /// <param name="dir"></param>
        private static void PlaceBoat(int x, int y, int size, Directions dir, Boats boat)
        {
            switch (dir)
            {
                case Directions.North:
                    for (int i = y - size + 1; i <= y; i++) boatPositions[x, i] = boat;
                    break;
                case Directions.South:
                    for (int i = y; i < y + size; i++) boatPositions[x, i] = boat;
                    break;
                case Directions.East:
                    for (int i = x; i < x + size; i++) boatPositions[i, y] = boat;
                    break;
                case Directions.West:
                    for (int i = x - size + 1; i <= x; i++) boatPositions[i, y] = boat;
                    break;
                default:
                    break;
            }
        }

        /// <summary>
        /// Returns the number of squares the boat takes up (the size)
        /// </summary>
        /// <param name="boat"></param>
        /// <returns></returns>
        public static int GetBoatSize(Boats boat)
        {
            switch (boat)
            {
                case Boats.Carrier: return 5;
                case Boats.Battleship: return 4;
                case Boats.Submarine: return 3;
                case Boats.Cruiser: return 3;
                case Boats.Destroyer: return 2;
                default: return 0;
            }
        }

        #endregion

    }
}
