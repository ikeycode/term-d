/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.colors.ansi
 *
 * Definitions for the ANSI colors + attributes
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module term.colors.ansi;

/** 
 * Modifiers to the standard set
 */
public enum ANSIColorModifier : ubyte
{
    /** This is a background color */
    background = 10,

    /** This is a bright color */
    bright = 60
}

/** 
 * Convenient mapping of the ANSI colors
 */
public enum ANSIColor : ubyte
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
}

/** 
 * ANSI cell display attributes
 */
public enum ANSIAttribute : ubyte
{
    reset = 0,          /// Reset all attributes,
    bold = 1,           /// Enable bold
    dim = 2,            /// Faint rendering
    italic = 3,         /// Italic text, not widely supported
    underline = 4,      /// Underlined, not widely supported
    blink = 5,          /// Slow blinking text
    reverse = 7,        /// invert fg + bg colors
    hidden = 8,         /// Hidden text (just use space or star..)
    strikeThrough = 9,  /// Crossed out text

    resetBold = 21,     /// turn off bold
    resetDim = 22,      /// turn off dim/faint
    resetItalic = 23,   /// turn off italics
    resetUnderline = 24,/// turn off underline
    resetBlink = 25,    /// stop blinking pls.
    resetReverse= 27,   /// invert the inverse
    resetHidden = 28,   /// show me!
}