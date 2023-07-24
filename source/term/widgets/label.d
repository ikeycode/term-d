/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.widgets.label
 *
 * The simplest of all widgets - a display label
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module term.widgets.label;

import term.widgets.widget;
import std.range.primitives : walkLength;
import std.uni : byGrapheme;

@safe:

/**
 * Provides a very simple Label widget
 */
public class Label : Widget
{
    /**
     * Construct a new Label with an optional string
     */
    this(string text = null)
    {
        this.text = text;
    }

    /** 
     * Update the label, and the full display width
     *
     * Params:
     *   text = New display label
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

private:

    string _text;
    ulong displayLength;
}
