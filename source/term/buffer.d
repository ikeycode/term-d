/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.buffer
 *
 * Provides a simple, managed terminal buffer
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module term.buffer;

@safe:

public import term.cell;

import std.experimental.allocator;
import std.experimental.allocator.mallocator;

/// The buffer grows twice as big as the input request to prevent further allocations
const growthFactor = 2;

/** 
 * A display buffer to manage a grid of cells, handling
 * allocation internally.
 *
 * It will happily grow, but will never shrink.
 */
public final class Buffer
{

    @disable this();

    /** 
     * Construct a new Buffer
     *
     * Params:
     *   width = Required width
     *   height = Required height
     */
    this(ulong width, ulong height) @nogc nothrow
    {
        this._width = width;
        this._height = height;

        memory = Mallocator.instance.makeArray!(Cell)(width * height * growthFactor, Cell.init);
        assert(memory !is null, "Fatal allocation error");
        allocatedWidth = width * growthFactor;
        allocatedHeight = height * growthFactor;
        allocatedSize = allocatedHeight * allocatedWidth;
    }

    /** 
     * Returns: Usable width
     */
    pure @property ulong width() => _width;

    /** 
     * Returns: Usable height
     */
    pure @property ulong height() => _height;

    /** 
     * Restricted window into the currently visible buffer
     *
     * Returns: ubyte[] minimised to the visible region.
     */
    auto opSlice() @nogc nothrow => memory[0 .. (_width * _height)];

    ~this() @nogc
    {
        release();
    }

    /** 
     * Request a resize of the buffer
     * Params:
     *   width = New width for the buffer
     *   height = New height for the buffer
     */
    void resize(ulong width, ulong height) @nogc nothrow
    {
        // No need to shrink the array
        _width = width;
        _height = height;

        auto newSize = width * height;

        if (newSize < allocatedSize)
        {
            return;
        }

        newSize *= growthFactor;
        const delta = newSize - allocatedSize;
        const resized = () @trusted {
            return Mallocator.instance.expandArray(memory, delta);
        }();
        if (!resized)
        {
            assert(0, "Growth failure");
        }
        allocatedHeight = height * growthFactor;
        allocatedWidth = width * growthFactor;
        allocatedSize = allocatedWidth * allocatedHeight;
    }

    /** 
     * Release all resources
     */
    void release() return @nogc nothrow
    {
        if (allocatedHeight < 0)
            return;

        // free the memory
        allocatedHeight = 0;
        () @trusted { Mallocator.instance.dispose(memory); }();
    }

private:

    ulong _width;
    ulong _height;
    Cell[] memory;

    ulong allocatedWidth;
    ulong allocatedHeight;
    ulong allocatedSize;
}

@safe unittest
{
    auto b = new Buffer(1, 1);
    scope (exit)
        b.release();
    b.resize(5, 5);
}
