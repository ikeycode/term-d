/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.widgets.text
 *
 * The simplest of all widgets - display a string
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module term.widgets.text;

import term.widgets.widget;
import std.range.primitives : walkLength;
import std.uni : byGrapheme;

@safe:

/**
 * Provides a very simple Text widget
 */
public class Text : Widget
{
    /**
     * Construct a new Text with an optional string
     */
    this(string text = null)
    {
        this.text = text;
    }

    /** 
     * Update the Text, and the full display width
     *
     * Params:
     *   text = New display Text
     * Returns: A reference to this
     */
    @property ref auto text(string text)
    {
        _text = text;
        if (!text)
        {
            displayLength = 0;
            return this;
        }
        displayLength = _text.byGrapheme.walkLength;
        return this;
    }

    override void draw()
    {
    }

private:

    string _text;
    ulong displayLength;
}
