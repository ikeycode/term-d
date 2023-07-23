/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.geometry.point;
 *
 * Point (2D) management
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module term.geometry.point;

@safe:

import std.traits : isNumeric, isFloatingPoint, isBoolean;

/** 
 * Standard Point type in term-d is int
 */
public alias Point = PointType!int;

/** 
 * Generic PointType.
 * 
 * Throughout term-d we currently use an integer based position
 * system, aliased to [Point]
 *
 * Params:
 *  I = Integral (Integer type)
 */
public struct PointType(I) if (isNumeric!I && !is(I == float) && !isBoolean!I)
{
    alias Integral = I;

    /** 
     * We're built from a vector of two ins
     */
    Integral[2] data;
    alias data this;

    /** 
     * Construct a PointType from the input data
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
     *   a = Point start (x)
     *   b = Point end (y)
     */
    this(Integral a, Integral b) @nogc nothrow
    {
        this.data = [a, b];
    }

    /** 
     * Update the X property
     *
     * Params:
     *   x = New X value
     * Returns: Reference to this
     */
    pure @property ref PointType!Integral x(Integral x) @nogc nothrow
    {
        data[0] = x;
        return this;
    }

    /** 
     * Returns: The X value
     */
    pragma(inline, true) pure @property x() @nogc nothrow const => data[0];

    /** 
     * Update the Y property
     *
     * Params:
     *   y = New Y value
     * Returns: Reference to this
     */
    pure @property ref PointType!Integral y(Integral y) @nogc nothrow
    {
        data[1] = y;
        return this;
    }

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

    /** 
     * Returns: the Y value
     */
    pragma(inline, true) pure @property y() @nogc nothrow const => data[1];
}

@("Basic point usage") @safe unittest
{
    auto p = Point(12, 14);
    assert(p == [12, 14]);
    static assert(!__traits(compiles, PointType!bool));
    static assert(__traits(compiles, PointType!double));
    static assert(!__traits(compiles, PointType!float));

    p *= 10;
    assert(p == [120, 140]);
}
