# Grids

<img src='Grids/Resources/Assets.xcassets/GridsAppIcon.imageset/Grids%20v2%20Icon-iOS-Default-1024x1024@1x.png' width='128' align='right' />

Create and edit Taiji puzzles for What the Taiji?! on macOS and Linux.

**Grids** is a free puzzle editor for Mac and Linux devices that lets you
create and edit puzzle in the style/mechanics of
[Taiji](https://taiji-game.com), saved as
[What the Taiji?!](https://marquiskurt.itch.io/what-the-taiji) puzzle files. 
Grids is designed to look native on macOS and Linux and provide a pleasant
editing experience.

![Screenshot of the editor](.readme/screenshot.png)

**Features**  
- Create and manage multiple puzzles together in a single set.
- Adjust the layout of the grid with the Layout Editor.
- Paint, flip, and erase tiles easily.
- Preview your puzzle in a small player.
- Quickly share puzzles with friends.

## Build from source

### Build for macOS

**Requirements**  
- macOS Sequoia (15.0) or later
- Xcode 16.2 or later

Start by cloning this repository with `git clone`, then open the
Grids.xcworkspace file on your Mac. Finally, select the "Grids" target and
run the project.

### Build for Linux/Adwaita

> **Note**  
> The Linux/Adwaita version is still a work in progress and is not fully
> featured compared to its macOS counterpart. Proceed with caution.

**Requirements**  
- GNOME Builder
- Swift v6 or later

Start by cloning this repository with `git clone`, then open the
`GridsAdwaita` project in GNOME Builder. Dependencies should be fetched
automatically within GNOME Builder.

Finally, press the Run button in GNOME Builder to build and run the
project.

## License

Grids is free and open-source software licensed under the MIT License.

### Credits

Taiji and the Taiji puzzle mechanics were created by Matthew VanDevander.

The classic Grids icon was created by VegasOs.

Grids was made possible thanks to the following open-source software:

- **Adwaita for Swift**: MIT License
- **DocumentKit**: MPLv2 License
- **PuzzleKit**: MIT License

Special thanks to these amazing people:
- Grant Neufeld
- femialiu
- joeisanerd
- 2DArray
- rae
- Paul Straw
- Doge4ever05
- Matthew VanDevander
- david-swift
