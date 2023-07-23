/*
 * SPDX-FileCopyrightText: Copyright © 2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * term.geometry.rectangle;
 *
 * Rectangle (2D) management
 *
 * Authors: Serpent OS Developers
 * License: Zlib
 * Copyright: © 2023 Serpent OS Developers
 */

module term.geometry.rectangle;

@safe:

public import term.geometry.point;
import std.traits : isNumeric, isFloatingPoint, isBoolean;

/** 
 * Default 2D rectangle uses int
 */
public alias Rectangle = RectangleType!int;

/**
 * A rectangle is simply two [Point]s with a start and end location.
 */
public struct RectangleType(I) if (isNumeric!I && !is(I == float) && !isBoolean!I)
{
    alias Integral = I;

    /// We're a vector of 4 ints, in essence. Should autovectorise.
    PointType!(Integral)[2] points;

    alias points this;

    /** 
     * Construct a Rectangle with the given start and end points
     * Params:
     *   start = Start point (X,Y)
     *   end =  End point (X, Y)
     */
    this(PointType!Integral start, PointType!Integral end) @nogc nothrow
    {
        points = [start, end];
    }

    /**
     * Construct a Rectangle with position and no width/height
     */
    this(Integral x, Integral y) @nogc nothrow
    {
        points = [
            PointType!Integral(x, y),
            PointType!Integral(x, y),
        ];
    }

    /** 
     * Construct a new rectangle with explicit coordinates
     * Params:
     *   x = x position
     *   y = y position
     *   w = width
     *   h = height
     */
    this(Integral x, Integral y, Integral w, Integral h) @nogc nothrow
    {
        points = [
            PointType!Integral(x, y),
            PointType!Integral(x + w, y + h)
        ];
    }

    /** 
     * Returns: The implicit width of the rectangle
     */
    pragma(inline, true) pure @property auto width() const @nogc nothrow
    {
        return points[1].x - points[0].x;
    }

    /** 
     * Update the width property
     * Params:
     *   w = New width
     * Returns: Reference to this
     */
    pragma(inline, true) pure @property ref auto width(Integral w) @nogc nothrow
    {
        points[1].x = points[0].x + w;
        return this;
    }

    /** 
     * Returns: The implicit height of the rectangle
     */
    pragma(inline, true) pure @property auto height() const @nogc nothrow
    {
        return points[1].y - points[0].y;
    }

    /** 
     * Update the height property
     * Params:
     *   h = New height
     * Returns: Reference to this
     */
    pragma(inline, true) pure @property ref auto height(Integral h) @nogc nothrow
    {
        points[1].y = points[0].y + h;
        return this;
    }

    /** 
     * Returns: the start (X) position
     */
    pragma(inline, true) pure @property auto x() @nogc nothrow  => points[0].x;

    /** 
     * Update the start (X) position
     *
     * Params:
     *   x = New start X position
     * Returns: Reference to this
     */
    pragma(inline, true) pure @property auto ref x(Integral x) @nogc nothrow
    {
        points[0].x = x;
        return this;
    }

    /** 
     * Returns: The start (Y) position
     */
    pragma(inline, true) pure @property auto y() @nogc nothrow => points[0].y;

    /** 
     * Updarte the start (Y) position
     *
     * Params:
     *   y = New start Y position
     * Returns: Reference to this
     */
    pragma(inline, true) pure @property auto ref y(Integral y) @nogc nothrow
    {
        points[0].y = y;
        return this;
    }

    /** 
     * Returns: Start point
     */
    pure @property auto ref start() @nogc nothrow => points[0];

    /** 
     * Returns: End point
     */
    pure @property auto ref end() @nogc nothrow => points[1];

    /** 
     * Perform op + assign (i.e. `*= value`) on *both* parts of the Rectangle
     *
     * This relies on the Integral arrays builtin support
     *
     * Params:
     *   value = Value to assign with op
     */
    void opOpAssign(string op, T)(T value) @nogc nothrow if (is(T : Integral))
    {
        mixin("start " ~ op ~ "= value;");
        mixin("end " ~ op ~ "= value;");
    }
}

/** 
 * Convenience construction of Rectangles
 */
pure auto rectangle() => Rectangle();

@("Basic rectangle support") @safe
unittest
{
    auto r = rectangle
        .x(5).y(5)
        .width(5).height(5);

    assert (r.end.x == 10);
    r *= 2;
    assert (r.end.x == 20);
    assert (r.start.x == 10);
}