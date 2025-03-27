# Godot 4 Day-Night Cycle System

This repository contains the completed code for my Godot 4 Day-Night Cycle tutorial. This system provides a super simple day and night cycle that can enhance the atmosphere and gameplay of your projects.

## Features

- Smooth transition between day and night states
- Directional light that simulates sun movement
- Time-based lighting system
- Customizable cycle duration
- Animation player for smooth sun arc movement
- Easy integration with existing projects
- Performance optimized implementation

## Getting Started

1. Clone or download this repository
2. Open the project in Godot 4.x
3. Run the title scene to see the day-night system in action
4. Explore the code to understand how it works

## How to Use in Your Own Project

### Basic Implementation

1. Copy the directional light setup from the demo scene
2. Add the Animation Player with sun rotation animation
3. Include the cycle controller script
4. Customize cycle timing and lighting properties

### Extending Functionality

The system could easily be extended with:
- Weather effects tied to time of day
- Different lighting for different biomes or areas
- Gameplay mechanics that change with time of day
- Moon lighting for night time
- NPC schedules based on time of day

## Project Structure

- `Scenes/title.tscn` - Example title screen
- `Scenes/demo_level.tscn` - First example level with day-night cycle (where the day-night cycle is)
- `Scenes/player.tscn` - Player character

## How It Works

The system uses a DirectionalLight node to simulate the sun, with an AnimationPlayer to control its rotation throughout the day. The lighting properties (color, intensity, shadow parameters) are adjusted based on the time of day to create realistic dawn, day, dusk, and night effects.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Thank You!

Thank you for downloading this simple little day-night cycle demo. I hope it helps improve the immersion and atmosphere in your games, or at least gets you started. If you have any questions or issues, create an issue in this repo or comment on one of my videos.
