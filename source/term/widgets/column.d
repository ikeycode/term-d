/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.widgets.column
 *
 * A column provides a vertical stack for placing widgets
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module term.widgets.column;

@safe:

public import term.widgets.widget;
import std.traits : CommonType;

/** 
 * Columns organised widgets in vertically stacked spaces
 */
public class Column : Widget
{

    /** 
     * Returns: The list of owned children
     */
    override Widget[] children() @nogc nothrow => widgets;

    override void draw()
    {
    }

    /** 
     * Add a widget to this column
     *
     * Params:
     *   w = Widget to take ownership of
     *
     * Returns: Reference to this
     */
    Column add(Widget w)
    {
        widgets ~= w;
        return this;
    }

    /** 
     * Remove a widget from our ownership
     *
     * Params:
     *   w = Old widget
     * Returns: Reference to this
     */
    Column remove(Widget w) @trusted
    {
        import std.algorithm : remove, SwapStrategy;

        widgets = children.remove!(a => a == w)();
        return this;
    }

private:

    Widget[] widgets;
}

/** 
 * Utility: Construct a column
 *
 * Params:
 *   args = Widgets to instantiate the column with
 * Returns: Newly allocated Column object
 */
public Column column(Args...)(Args args)
        if (args.length == 0 || is(CommonType!Args : Widget))
{
    auto c = new Column();
    static foreach (arg; args)
    {
        c.add(arg);
    }
    return c;
}
