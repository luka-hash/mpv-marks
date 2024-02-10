# mpv-marks

Suckless (video)marking solutions for mpv.

It creates a file with the name of the video you are watching with the additional `.marks` extension, and each line of the file is one timestamp.

Why would you need that? If you need to ask, you don't need this plugin. :)

## Installation

Put the `marks.lua` file in the `~/.config/mpv/scripts/` directory (or relevant directory on non-linux operating systems).

You will also need a notification-daemon, like dunst, if you want to have on screen notifications when you add/remove marks.

## Usage

- `b` do (add) mark
- `B` undo (remove) mark

## TODO

- [x] Add on-screen notifications

## Licence

This code is licensed under MIT licence (see LICENCE for details).

