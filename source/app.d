/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * app
 *
 * Test UI
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module app;

import term.renderer;
import term.widgets;

void main()
{
    auto renderer = new Renderer();

    // dfmt off
    auto root = column(
        column(
            text("col 1, row 1"),
            text("col 1, row 2")
        ),
        column(
            text("col 2, row 1"),
            text("col 2, row 2")
        )
    );
    // dfmt on

    renderer.render(root);
    scope (exit)
    {
        renderer.release();
    }
}
