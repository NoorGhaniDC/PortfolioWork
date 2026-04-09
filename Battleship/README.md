<<<<<<< HEAD
# Battleship Game

A single-player Battleship game built with C# and Windows Forms, developed for Durham College coursework.

**Developer:** Noor Ghani  
**Academic Year:** 2024-25  

## Overview

This is a desktop implementation of the classic Battleship strategy game. Players position their ships on a grid and attempt to sink the computer's fleet by guessing coordinates. The application features a traditional Windows Forms GUI with an intuitive interface for gameplay.

## Technology Stack

- **Language:** C#
- **Framework:** .NET Framework 4.8
- **UI Framework:** Windows Forms
- **Build System:** MSBuild / Visual Studio

## Features

- Single-player gameplay against the computer
- Grid-based ship placement system
- Hit/miss tracking
- Game state management and turn sequences
- Windows Forms GUI with visual feedback

## Project Structure

```
Battleship/
├── frmMain.cs              # Main game form and UI logic
├── frmMain.Designer.cs     # Auto-generated form designer code
├── BS.cs                   # Core Battleship game logic
├── Tools.cs                # Utility functions
├── Settings.cs             # Game configuration and settings
├── Program.cs              # Application entry point
├── Battleship.csproj       # Project file
├── Battleship.sln          # Solution file
├── App.config              # Application configuration
└── Properties/             # Assembly and resource files
```

## Getting Started

### Prerequisites

- .NET Framework 4.8 or later
- Visual Studio 2019/2022 or equivalent build tools

### Building

1. Open `Battleship.sln` in Visual Studio
2. Build the solution (Build → Build Solution)
3. Run the application (F5 or Debug → Start Debugging)

Alternatively, build from the command line:
```bash
msbuild Battleship.sln /p:Configuration=Release
```

### Running

Execute the compiled `.exe` file from the output directory:
```
bin\Debug\Assignment2.exe
```

## How to Play

1. **Setup Phase:** Position your ships on the grid
2. **Attack Phase:** Click grid coordinates to attack the opponent's fleet
3. **Win Condition:** Sink all opponent ships before they sink yours

## Installation

No additional installation required. The application is standalone and can be run directly from the compiled executable.

## License

Academic project - Created for Durham College coursework
=======

Battleship

Description:

This application is a single player version of Battleship built in C#.

Technologies:
- C#
- Visual Studio
- WinForms
- Git

Features:
- Sound Effects
- Randomized Boats
- Alternate Controls (Playable with both only mouse or only keyboard)


Author:
Noor Ghani

This application was designed and developed by Noor Ghani as a part of their coursework for Durham College in the 2024-25 academic year.
>>>>>>> 0535b048eac0f8cbecd9cb6e655b168a77b19664
