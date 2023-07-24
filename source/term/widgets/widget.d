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
import term.geometry.rectangle;

/**
 * All term-d widgets are derived from Widget in a
 * very shallow tree.
 */
public abstract class Widget
{
    /** 
     * Request that this widget draw itself
     */
    abstract void draw();
}
