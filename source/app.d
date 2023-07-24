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
    auto lab = new Label();
    renderer.render(lab);
    scope (exit)
    {
        renderer.release();
    }
}
