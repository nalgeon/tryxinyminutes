---
x: Rough.js
title: Try Rough.js in Y minutes
image: /try/rough-js/cover.png
lastmod: 2024-02-24
original: https://roughjs.com/
license: MIT
contributors:
    - ["Preet Shihn", "https://github.com/pshihn"]
    - ["Anton Zhiyanov", "https://antonz.org"]
---

[Rough.js](https://roughjs.com/) is a small (<9KB gzipped) graphics library that lets you draw in a _sketchy_, _hand-drawn_ style. The library defines primitives for lines, curves, arcs, polygons, circles, and ellipses. Rough.js works with both Canvas and SVG.

Let's see Rough.js in action! You can edit the code at any time and click the Run button to see the updated drawing.

[Basic usage](#basic-usage) ·
[Shapes](#shapes) ·
[Filling](#filling) ·
[Sketching style](#sketching-style) ·
[Further reading](#further-reading)

<div class="tryx__panel">
<p>✨ This is an open source guide. Feel free to <a href="https://github.com/nalgeon/tryxinyminutes/blob/main/try/rough-js/index.md">improve it</a>!</p>
</div>

## Basic usage

You can draw on a `canvas`:

```js
// `out-canvas` is a `canvas` tag
// defined below this code snippet
const canvas = document.getElementById("out-canvas");

// clear the canvas for redrawing
const context = canvas.getContext("2d");
context.clearRect(0, 0, canvas.width, canvas.height);

// draw a rectangle
const rc = rough.canvas(canvas);
rc.rectangle(20, 20, 200, 100); // x, y, width, height

// show the drawing
canvas.style.display = "block";
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" output-mode="hidden">
</codapi-snippet>

<pre><canvas id="out-canvas" width="250" height="140" style="display: none"></canvas></pre>

Or generate an `svg`:

```js
// `out-svg` is an `svg` tag
// defined below this code snippet
const svg = document.getElementById("out-svg");

// clear the svg for redrawing
svg.innerHTML = "";

// draw a rectangle
const rs = rough.svg(svg);
const node = rs.rectangle(20, 20, 200, 100); // x, y, width, height

// show the drawing
svg.appendChild(node);
svg.style.display = "block";
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" output-mode="hidden">
</codapi-snippet>

<pre><svg id="out-svg" width="250" height="140" style="display: none"></svg></pre>

Both `RoughCanvas` (an object returned by `rough.canvas`) and RoughSVG (an object returned by `rough.svg`) provide the same methods. The difference is that the `RoughSVG` methods return a node (`g`) that can be inserted into the SVG DOM.

I will be using `RoughCanvas` from now on.

## Shapes

Draw a **line** from `(x1, y1)` to `(x2, y2)`:

```js
// `init` is a helper function I'm using in the examples.
// It initializes a RoughCanvas on the element with the given ID
// just like we did above.
const rc = init("c01");

rc.line(20, 20, 160, 60);
rc.line(20, 40, 160, 80, { strokeWidth: 5 });
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c01" width="250" height="100"></canvas></pre>

Draw a **rectangle** with the top-left corner at `(x, y)` and the specified `width` and `height`:

```js
const rc = init("c02");

rc.rectangle(20, 20, 100, 50);
rc.rectangle(140, 20, 100, 50, { fill: "red" });
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c02" width="260" height="90"></canvas></pre>

Draw a **circle** with the center at `(x, y)` and the specified `diameter`:

```js
const rc = init("c03");

rc.circle(60, 60, 80);
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c03" width="250" height="120"></canvas></pre>

Draw an **ellipse** with the center at `(x, y)` and the specified `width` and `height`:

```js
const rc = init("c04");

rc.ellipse(70, 50, 100, 60);
rc.ellipse(190, 50, 100, 60, { fill: "blue", stroke: "red" });
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c04" width="250" height="100"></canvas></pre>

Draw a **set of lines** connecting the specified `points`:

```js
const rc = init("c05");

// linearPath accepts an array of points.
// Each point is an array with values [x, y].
rc.linearPath([
    [20, 70],
    [70, 20],
    [120, 70],
    [170, 20],
    [220, 70],
]);
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c05" width="250" height="90"></canvas></pre>

Draw a **polygon** with the specified `vertices`:

```js
const rc = init("c06");

// polygon accepts an array of points.
// Each point is an array with values [x, y].
rc.polygon([
    [20, 70],
    [70, 20],
    [120, 50],
    [170, 20],
    [220, 70],
]);
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c06" width="250" height="90"></canvas></pre>

Draw an **arc**:

```js
// An arc is described as a section of an ellipse.
arc(x, y, width, height, start, stop, closed [, options]) {}
// x, y          - the center of the ellipse.
// width, height - the dimensions of the ellipse.
// start, stop   - the start and stop angles for the arc.
//
// closed is a boolean.
// If true, the end points of the arc will be connected to the center.

```

```js
const rc = init("c07");

// upper left segment
rc.arc(70, 60, 100, 80, Math.PI, Math.PI * 1.6, true);

// lower right segment
rc.arc(70, 60, 100, 80, 0, Math.PI / 2, true, {
    stroke: "red",
    strokeWidth: 4,
    fill: "rgba(255,255,0,0.4)",
    fillStyle: "solid",
});

// lower left segment
rc.arc(70, 60, 100, 80, Math.PI / 2, Math.PI, true, {
    stroke: "blue",
    strokeWidth: 2,
    fill: "rgba(255,0,255,0.4)",
});
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c07" width="250" height="120"></canvas></pre>

Draw a **curve** passing through the points:

```js
const rc = init("c08");

// curve accepts an array of points.
// Each point is an array with values [x, y].
rc.curve([
    [20, 70],
    [70, 20],
    [120, 70],
    [170, 20],
    [220, 70],
]);
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c08" width="250" height="90"></canvas></pre>

Draw a **path** described by an [SVG path](https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths) data string:

```js
const rc = init("c09");

rc.path("M 20 70 C 50 0, 75 0, 105 70 S 160 140, 190 70", {
    stroke: "blue",
    fill: "green",
});
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c09" width="250" height="140"></canvas></pre>

Write some **text** using the Canvas API:

```js
const rc = init("c10");

// draw two rectangles and an arrow
rc.rectangle(20, 20, 100, 50);
rc.rectangle(220, 20, 100, 50);
rc.line(120, 45, 220, 45);
rc.line(220, 45, 200, 40);
rc.line(220, 45, 200, 50);

// write some text
const ctx = rc.canvas.getContext("2d");
ctx.font = "16px sans-serif";
ctx.fillStyle = "blue";
ctx.fillText("Rough.js", 40, 50);
ctx.fillText("is", 160, 40);
ctx.fillText("awesome", 240, 50);
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c10" width="350" height="90"></canvas></pre>

## Filling

The `fill` property specifies the color used to fill a shape. Uses hachure by default:

```js
const rc = init("c11");

rc.circle(60, 60, 80, { fill: "red" });
rc.rectangle(120, 20, 80, 80, { fill: "red" });
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c11" width="250" height="120"></canvas></pre>

You can change the hatch angle and line thickness, or choose a different fill style altogether:

```js
const rc = init("c12");

// hatch angle
rc.rectangle(20, 20, 80, 80, {
    fill: "red",
    hachureAngle: 60,
    hachureGap: 8,
});

// thicker lines
rc.circle(160, 60, 80, {
    fill: "rgb(10,150,10)",
    fillWeight: 3,
});

// solid fill instead of hachure
rc.rectangle(220, 20, 80, 80, {
    fill: "rgba(255,0,200,0.2)",
    fillStyle: "solid",
});
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c12" width="310" height="120"></canvas></pre>

You can use the following fill styles:

```js
const rc = init("c13");

// hachure (default) draws sketchy parallel lines.
rc.rectangle(20, 20, 80, 80, {
    fill: "blue",
});

// solid is more like a conventional fill.
rc.rectangle(120, 20, 80, 80, {
    fillStyle: "solid",
    fill: "blue",
});

// zigzag draws zigzag lines that fill the shape.
rc.rectangle(220, 20, 80, 80, {
    fillStyle: "zigzag",
    fill: "blue",
});

// cross-hatch is similar to hachure, but draws cross-hatched lines.
rc.rectangle(320, 20, 80, 80, {
    fillStyle: "cross-hatch",
    fill: "blue",
});
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c13" width="420" height="120"></canvas></pre>

And even more:

```js
const rc = init("c14");

// dots fills the shape with sketchy dots.
rc.rectangle(20, 20, 80, 80, {
    fillStyle: "dots",
    fill: "blue",
});

// dashed is similar to hachure, but the lines are dashed.
rc.rectangle(120, 20, 80, 80, {
    fillStyle: "dashed",
    fill: "blue",
    dashOffset: 5,
    dashGap: 5,
});

// zigzag-line is similar to hachure,
// but the lines are drawn in a zigzag pattern.
rc.rectangle(220, 20, 80, 80, {
    fillStyle: "zigzag-line",
    fill: "blue",
    zigzagOffset: 3,
});
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c14" width="420" height="120"></canvas></pre>

## Sketching style

You can control the _roughness_ of the drawing:

```js
const rc = init("c21");

// A rectangle with the roughness of 0 would be a perfect rectangle.
rc.rectangle(20, 20, 80, 80, {
    roughness: 0,
    fill: "red",
});

// The default value is 1.
rc.rectangle(120, 20, 80, 80, {
    roughness: 1,
    fill: "blue",
});

// There is no upper limit to this value.
rc.rectangle(220, 20, 80, 80, {
    roughness: 3,
    fill: "green",
});

// But a value over 10 is mostly useless.
rc.rectangle(320, 20, 80, 80, {
    roughness: 5,
    fill: "gold",
});
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c21" width="420" height="120"></canvas></pre>

You can also control _bowing_:

```js
const rc = init("c22");

// Bowing indicates how curvy the lines are.
// A value of 0 will cause straight lines.
rc.rectangle(20, 20, 80, 80, {
    bowing: 0,
    fill: "red",
});

// The default value is 1.
rc.rectangle(120, 20, 80, 80, {
    bowing: 1,
    fill: "blue",
});

// There is no upper limit to this value.
rc.rectangle(220, 20, 80, 80, {
    bowing: 8,
    fill: "green",
});

// But a value over 20 is mostly useless.
rc.rectangle(320, 20, 80, 80, {
    bowing: 20,
    fill: "gold",
});
```

<codapi-snippet engine="browser" sandbox="javascript" editor="basic" template="render.js" output-mode="hidden">
</codapi-snippet>

<pre style="display: none"><canvas id="c22" width="420" height="120"></canvas></pre>

## Further reading

Rough.js also supports other configuration options. See the [documentation](https://github.com/rough-stuff/rough/wiki) for details.

See the [project page](https://roughjs.com/) to start using Rough.js on your website or in your product.

<script src="https://unpkg.com/roughjs@4.6.6/bundled/rough.js" async></script>
