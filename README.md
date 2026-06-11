# Zoomer

A lightweight Hammerspoon utility that creates a dynamic spotlight effect around your cursor, helping you focus attention during presentations, screen sharing, demos, recordings, and tutorials.

## Features

- 🔦 Cursor-following spotlight effect
- 🎯 Highlights the active area around the mouse
- 🌑 Dims the rest of the screen
- ⚡ Real-time tracking with smooth updates
- 🖥️ Works across all Spaces
- 🎥 Great for presentations, demos, tutorials, and screen recordings

## How It Works

When enabled, Zoomer creates a fullscreen transparent overlay and continuously tracks your mouse position.

The screen is dimmed except for a rectangular focus area centered around the cursor:

```text
+----------------------------------+
|                                  |
|          Dimmed Area             |
|                                  |
|      +------------------+        |
|      |                  |        |
|      |   Focus Area     |        |
|      |                  |        |
|      +------------------+        |
|                                  |
|          Dimmed Area             |
|                                  |
+----------------------------------+
```

The spotlight follows the cursor in real time, making it easier for viewers to focus on the area you're discussing.

## Configuration

You can customize the spotlight dimensions and opacity:

```lua
local RECT_W = 400
local RECT_H = 250
local DIM_ALPHA = 0.85
```

| Variable | Description |
|-----------|------------|
| `RECT_W` | Width of the spotlight area |
| `RECT_H` | Height of the spotlight area |
| `DIM_ALPHA` | Darkness of the surrounding overlay |

## Usage

Load the module from your `init.lua`:

```lua
require("zoomer")
```

Reload Hammerspoon:

```text
Hammerspoon → Reload Config
```

Use the configured hotkey to toggle the spotlight on and off.
My hotkey is control + option + space

## Requirements

- macOS
- Hammerspoon
