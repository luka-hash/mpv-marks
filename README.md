# mpv-marks

Suckless (video)marking solutions for mpv.

It creates a file with the name of the video you are watching with the additional `.marks` extension, and each line of the file is one timestamp. That file you can easily parse and plug into a bigger pipeline, e.g. automatic video cutting/editing of live streams, automatic montage/compilation maker, etc.

Why would you need that? Why would I use this instead of X? If you need to ask, you don't need this plugin. :)

## Installation

Put the `marks.lua` file in the `~/.config/mpv/scripts/` directory (or relevant directory on non-linux operating systems).

## Usage

- `b` do (add) mark
- `B` undo (remove) mark
- `c` add cut command (for purposes of programmable editing, or something similar)

## TODO
-   

## Licence

This code is licensed under the terms of the MIT licence (see `LICENCE` for details).

