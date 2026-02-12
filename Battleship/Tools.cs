/* COSC2100 - Assignment 2
 * Noor Ghani, 100597372
 * October 13, 2024
 * Contains various generic tools that is used
 * for the Battleship Game.
 * */

using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assignment2
{
    public static class Tools
    {
        /// <summary>
        /// Tool for random instances..
        /// </summary>
        private static Random random = new Random();
        /// <summary>
        /// Tool for generating a random number
        /// </summary>
        /// <param name="min"></param>
        /// <param name="max"></param>
        /// <returns></returns>
        public static int RandomInt (int min, int max)
        {
            return random.Next(min, max);
        }
        /// <summary>
        /// Tool for random color.
        /// </summary>
        /// <returns></returns>
        public static Color RandomColor()
        {
            return Color.FromArgb(255, RandomInt(0, 255), RandomInt(0,255), RandomInt(0,255));
        }



    }
}
