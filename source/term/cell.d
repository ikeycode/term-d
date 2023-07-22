/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.cell
 *
 * Provides simplified terminal cell abstraction
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module term.cell;

public import term.colors : ANSIAttribute, Color, ANSIColor;

/** 
 * Simple abstraction to manage a Buffer in terms of displayable
 * cells. The layout is intended to give the best compaction possible
 */
public struct Cell
{
    static assert(Cell.sizeof == 16);

    /** 
     * Rendering attributes for the cell
     */
    ANSIAttribute attrs;

    /** 
     * Foreground color
     */
    Color fg = Color(ANSIColor.white);

    /** 
     * Background color
     */
    Color bg = Color(ANSIColor.white);

    /**
     * 32-bit content (grapheme aware)
     */
    dchar content;
}
