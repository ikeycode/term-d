/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.renderer
 *
 * Rendering for term-d
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module term.renderer;

@safe:

import term.buffer;
import term.widgets.widget;

/** 
 * The renderer holds the buffers to be drawn along with some
 * methods for rendering a specific widget (tree) efficiently.
 */
public final class Renderer
{

    /** 
     * Construct a new Renderer with 2 buffers
     */
    this() nothrow
    {
        backBuffer = new Buffer(80, 24);
        frontBuffer = new Buffer(80, 24);

        backBuffer.clear();
        frontBuffer.clear();
    }

    /** 
     * Render using the given widget tree
     */
    void render(scope Widget root) @nogc
    {
        // Nothing to render, nothing has changed
        if (backBuffer[] == frontBuffer[])
        {
            return;
        }

        swapBuffers();

        // TODO: Render front buffer (stored in back buffer)
    }

    /** 
     * Release all resources
     */
    void release() return @nogc nothrow
    {
        backBuffer.release();
        frontBuffer.release();
    }

    ~this() @nogc nothrow
    {
        backBuffer.release();
        frontBuffer.release();
        backBuffer = null;
        frontBuffer = null;
    }

private:

    /** 
     * Swap the internal buffers for the next draw queue.
     */
    void swapBuffers() @nogc nothrow
    {
        imported!"std.algorithm.mutation".swap(backBuffer, frontBuffer);
    }

    Buffer backBuffer;
    Buffer frontBuffer;
}
