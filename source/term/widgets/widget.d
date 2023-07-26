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
import term.geometry.size;
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
     * The widget is given a set of constraints from which it live.
     *
     * It must then pick an appropriate size between minimum/maximum
     * and account for its children.
     *
     * Params:
     *  minimum = Minimum space available
     *  maximum = Maximum space available
     * Returns: The chosen size.
     */
    Size constraints(const Size minimum, const Size maximum)
    {
        return maximum;
    }

    /**
     * Notify this widget it should update itself using the picked size
     * constraints.
     *
     * While implementations may not override this method, rendering will
     * be clipped to prevent breakage.
     */
    void layout(const Size size)
    {
    }

    /** 
     * Container widgets can return the widgets they own here
     *
     * Returns: Owned slice of children
     */
    pure Widget[] children() @nogc nothrow => null;
}
