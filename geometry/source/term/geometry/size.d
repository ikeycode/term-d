/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.geometry.size;
 *
 * Size (2D) management
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module term.geometry.size;

@safe:

import std.traits : isNumeric, isFloatingPoint, isBoolean;

/** 
 * In term-d we default to integer precision
 */
public alias Size = SizeType!int;

/** 
 * Size type is essentially a point with renamed members
 */
public struct SizeType(I)
{
    alias Integral = I;

    /** 
     * We're built from a vector of two ints
     */
    Integral[2] data;
    alias data this;

    /** 
     * Construct a SizeType from the input data
     *
     * Params:
     *   data = Raw input data
     */
    this(Integral[2] data) @nogc nothrow
    {
        this.data = data;
    }

    /** 
     * 
     * Params:
     *   w = width
     *   h = height
     */
    this(Integral w, Integral h) @nogc nothrow
    {
        this.data = [w, h];
    }

    /** 
     * Update the width property
     *
     * Params:
     *   w = New width value
     * Returns: Reference to this
     */
    pure @property ref SizeType!Integral width(Integral w) @nogc nothrow
    {
        data[0] = w;
        return this;
    }

    /** 
     * Returns: The width value
     */
    pragma(inline, true) pure @property width() @nogc nothrow const => data[0];

    /** 
     * Update the height property
     *
     * Params:
     *   h = New height value
     * Returns: Reference to this
     */
    pure @property ref SizeType!Integral height(Integral h) @nogc nothrow
    {
        data[1] = h;
        return this;
    }

    /** 
     * Returns: the height value
     */
    pragma(inline, true) pure @property height() @nogc nothrow const => data[1];

    /** 
     * Perform op + assign (i.e. `*= value``)
     * This relies on the Integral arrays builtin support
     *
     * Params:
     *   value = Value to assign with op
     */
    void opOpAssign(string op, T)(T value) @nogc nothrow if (is(T : Integral))
    {
        mixin("data[] " ~ op ~ "= value;");
    }
}

/** 
 * Utility: construct new size
 *
 * Params:
 *   w = New width
 *   h = New heigh
 */
pure auto size(int w, int h) @nogc nothrow => Size(w, h);

@("Basic size test") @safe
unittest
{
    auto s = size(10, 20);
    s *= 5;
    assert(s[] == [50, 100]);
}