/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.widgets.widget
 *
 * Base interface for all widgets
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module term.widgets.widget;

@safe:

import term.geometry.rectangle;
import std.algorithm : each;

/**
 * All term-d widgets are derived from Widget in a
 * very shallow tree.
 */
public abstract class Widget
{
    /** 
     * Request that this widget draw itself
     * The implementation should pass this call onto any child widget
     */
    void draw()
    {
        // Default behaviour: Just ask children to draw, we're likely a
        // container.
        children.each!"a.draw()";
    }

    /** 
     * Container widgets can return the widgets they own here
     *
     * Returns: Owned slice of children
     */
    pure Widget[] children() @nogc nothrow => null;
}
