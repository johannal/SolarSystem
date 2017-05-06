Graphing Library - Overview
===========================

Motivation for the framework
---------------------------------
The graphing library provides a ***concise*** and ***simple*** API to create both line and scatter plots. In general the API avoids subclassing, in an effort to minimize the API surface area, which hopefully contributes to the ease of use of the API.

For detailed descriptions about the background behind the type of graphs you can create, see [Wikipedia line plot][line] page, and the [Wikipedia scatter plot][scatter] page.

> Checkout [Graph Defined][definitions] for a more thourough description about the different types of graphs, which will give you a better understanding of whats provided here.

**Note:** This library is released under the [Apache 2.0 license][license].

  [line]: https://en.wikipedia.org/wiki/Line_chart  "Line Plot"
  [scatter]: https://en.wikipedia.org/wiki/Scatter_plot  "Scatter Plot"
  [definitions]: https://en.wikipedia.org/wiki/Graph "Definitions"
  [license]: https://github.com/apple/swift/blob/master/LICENSE.txt "License"
  
## Primary Classes

### AbstractPointPlot

/// An abstract point-based plot that supports drawing points to the screen as symbols and connecting them with lines.

⁃    color: Color
⁃    The color to stroke the line with.
⁃    lineWidth: Double
⁃    The width of the line. The default value is 4.0.
⁃    symbol: Symbol?
⁃    The Symbol to use for points along the line. The default value is .circle.
⁃    style: LineStyle
⁃    The style to draw the line with (e.g. solid, dashed, etc.). The default value is .solid.
⁃    label: String?
⁃    The label of the data plotted. The default value is nil.


### Line: AbstractPointPlot

/// A line plot on the chart.
///
/// Here are some properties that affect the LinePlot:
///
///   - `color` The color to use for symbols and to stroke the line with.
///   - `lineWidth` The width of the line. The default value is 4.0.
///   - `symbol` The Symbol to use for points along the line. The default value is .circle.
///   - `style` The style to draw the line with (e.g. solid, dashed, etc.). The default value is .solid.

⁃    init(yData: Double...)
⁃    /// Creates a LinePlot with the given (x,y) data. The data will be sorted in ascending x order.
⁃    init(xyData: (Double, Double)...)
⁃    /// Creates a LinePlot with the given y data, starting at x=0 with an x-stride of 1.0. The data will be sorted in ascending x order.
⁃    init(xyData: XYData)
⁃    /// Creates a LinePlot with the given XYData. The data will be sorted in ascending x order.
⁃    init(function: (Double) -> Double)
⁃    /// Creates a LinePlot with the given function. The function will be called with an x value, and must return the corresponding y value.


### Scatter: AbstractPointPlot

/// A scatter plot on the chart.
///
/// Here are some properties that affect the ScatterPlot:
///
///   - `color` The color to use for symbols.
///   - `symbol` The Symbol to use for points. The default value is .circle.

⁃    init(xyData: (Double, Double)...)
⁃    /// Creates a ScatterPlot with the given (x,y) data.
⁃    init(xyData: XYData)
⁃    /// Creates a ScatterPlot with the given XYData.


### XYData

⁃    init(yData: [Double], startingX: Double = 0.0, xStride: Double = 1.0)
⁃    /// Creates a XYData with the given y data, starting at the given x, with the given x-stride.
///   - `yData` The color to use for symbols and to stroke the line with.
///   - `startingX` The x value to start the data at. The default value is 0.0
///   - `xStride` The delta between x values. The default value is 1.0.
⁃    init(xyData: (Double, Double)...)
⁃    /// Appends the given (x,y) point to this XYData.
⁃    append(x: Double, y: Double)
⁃    /// Appends the given (x,y) point to this XYData.
⁃    append(y: Double)
⁃    /// Appends the given y point to this XYData. The x value will be inferred based on the existing data.


## Support Classes

### Chart

⁃    shared: Chart (shared Chart instance)
⁃    /// The single shared chart that all plots are automatically added to.
⁃    bounds: Bounds
⁃    /// The bounds of this chart (minimum x, maximum x, minimum y and maximum y).

### Bounds: Equatable (struct)

⁃    minX: Double
⁃    maxX: Double
⁃    minY: Double
⁃    maxY: Double

### Symbol

/// A symbol used for representing a point on screen.

⁃    init(shape: Shape = .circle, size: 8.0 = default)
⁃ /// Creates a shape-based symbol.
///   - `shape` The type of shape. Defaults to .circle.
///   - `size` The size of the shape. Defaults to 8.0.
⁃    init(imageNamed imageName: String, size: Double = 32.0)
⁃    /// Creates an image-based symbol.
///   - `imageName` The name of the image in this playgrounds resources.
///   - `size` The size of the image. Defaults to 32.0.

### SymbolShape (enum)

/// Types of shapes that can be used to create Symbols.

⁃    .circle
⁃    .square
⁃    .triangle

### LineStyle (enum)

⁃    .none
⁃    .solid
⁃    .dashed
⁃    .dotted

### Color: _ColorLiteralConvertible

⁃    clear: Color
⁃    white: Color
⁃    gray: Color
⁃    black: Color
⁃    orange: Color
⁃    blue: Color
⁃    green: Color
⁃    yellow: Color
⁃    red: Color
⁃    purple: Color
⁃    init(red: Double, green: Double, blue: Double, alpha: Double = 1.0)
⁃    init(hue: Double, saturation: Double, brightness: Double, alpha: Double = 1.0)
⁃    withAlphaComponent(alpha: Double) -> Color
⁃    lighter(percent: Double = 0.2) -> Color
⁃    darker(percent: Double = 0.2) -> Color
⁃    random() -> Color

## Example Usages

### Line plots
#### Create a line plot
#### Multiple line plots
#### Create a line plot using XYData
#### Create a LinePlot using a function
### Scatter plots
#### Create a ScatterPlot with shape Symbols
#### Create a ScatterPlot with image Symbols
