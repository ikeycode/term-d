/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.colors
 *
 * Support for terminal colour definitions
 *
 * Authors: Copyright © 2023 Serpent OS Developers
 * License: Zlib
 */

module term.colors;

@safe:

import std.range : chunks, drop;
import std.algorithm : map;
import std.conv : to;
import std.array : array;

/** 
 * Modifiers to the standard set
 */
enum ANSIColorModifier : ubyte
{
    background = 10,
    bright = 60
}

/** 
 * Convenient mapping of the ANSI colors
 */
enum ANSIColor : ubyte
{
    black = 30,
    red = 31,
    green = 32,
    yellow = 33,
    blue = 34,
    magenta = 35,
    cyan = 36,
    white = 37,

    // Bright modifiers
    gray = black + ANSIColorModifier.bright,
    // Easy typo =P
    grey = gray,

    brightRed = red + ANSIColorModifier.bright,
    brightGreen = green + ANSIColorModifier.bright,
    brightYellow = yellow + ANSIColorModifier.bright,
    brightBlue = blue + ANSIColorModifier.bright,
    brightMagenta = magenta + ANSIColorModifier.bright,
    brightCyan = cyan + ANSIColorModifier.bright,
    brightWhite = white + ANSIColorModifier.bright,
};

/** 
 * Contraint for triplet matching
 *
 * Params:
 *   hex = Hex triplet string
 * Returns: true if triplet string matches "#XXXXXX"
 */
template isValidHexTriplet(string hex)
{
    enum isValidHexTriplet = hex.length == 7 && hex[0] == '#';
}

/** 
 * Encapsulation of an (S)RGB color as supported by xterm-256color
 *
 * Note: 3 bytes are supported for RGB, however we load as 4 bytes to
 * prevent unaligned access.
 */
struct Color
{
    /** Raw buffer */
    ubyte[4] data;

    /* dispatch everthing to .data */
    alias data this;

    /** 
     * Construct a new Color with the given RGB values
     *
     * Params:
     *   r = Red value (0-255)
     *   g = Green value (0-255)
     *   b = Blue value (0-255)
     *   fallback = ANSI fallback color
     */
    this(ubyte r, ubyte g, ubyte b, ANSIColor fallback = ANSIColor.white) @nogc
    {
        data[0] = r;
        data[1] = g;
        data[2] = b;
        data[3] = fallback;
    }

    /** 
     * Construct from a given ANSI color
     *
     * Params:
     *   ansi = ANSI Color
     */
    this(ANSIColor ansi) @nogc
    {
        data = 0;
        data[3] = ansi;
    }

    /** 
     * Truncate visible slice to first 3 elements
     * Returns: slice of first 3 elements allowing comparison
     */
    auto opSlice() => data[0 .. 3];

    /** 
     * Returns: red value
     */
    pragma(inline, true) pure @property red() @nogc => data[0];

    /** 
     * Update red value
     *
     * Params:
     *   r = New red value
     * Returns: Reference to this
     */
    pragma(inline, true) pure @property ref Color red(ubyte r) return @nogc
    {
        data[0] = r;
        return this;
    }

    /** 
     * Returns: green value
     */
    pragma(inline, true) pure @property green() @nogc => data[1];

    /** 
     * Update green value
     *
     * Params:
     *   g = New green value
     * Returns: Reference to this
     */
    pragma(inline, true) pure @property green(ubyte g) return @nogc
    {
        data[1] = g;
        return this;
    }

    /** 
     * Returns: blue value
     */
    pragma(inline, true) pure @property blue() @nogc => data[2];

    /** 
     * Update blue value
     *
     * Params:
     *   b = New blue value
     * Returns: Reference to this
     */
    pragma(inline, true) pure @property ref Color blue(ubyte b) return @nogc
    {
        data[2] = b;
        return this;
    }

    /** 
     * Construct a new Color from the given data buffer + fallback color
     * Params:
     *   data = Raw RGB values
     *   fallback = Fallback color
     */
    package this(ubyte[4] data, ANSIColor fallback = ANSIColor.white) @safe @nogc
    {
        this.data = data;
        data[3] = fallback;
    }
}

/** 
 * Form a new color using the given hex triplet
 *
 * The hex string will be calculated at compilation time
 *
 * Params:
 *  triplet = Hex triplet string (#XXXXXX)
 *  fallback = The fallback color to use (ANSI)
 *
 * Returns: new Color
 */
auto color(string triplet)(ANSIColor fallback = ANSIColor.white) @nogc
        if (isValidHexTriplet!triplet)
{
    static ubyte[4] cachedColor = (triplet ~ "00").drop(1).chunks(2)
        .map!(c => c.to!ubyte(16)).array;
    return Color(cachedColor[], fallback);
}

/** 
 * Construct a new Color using the given ANSI color code
 *
 * Params:
 *   ansi = ANSI color
 * Returns: new Color
 */
auto color(ANSIColor ansi) @nogc => Color(ansi);

@("Test the hex triplet conversion")
@safe unittest
{
    assert(color!"#87CEEB"[] == [135, 206, 235]);
}
