Graphing Library - Overview
===========================

Motivation for the framework
---------------------------------
The graphing library provides a ***concise*** and ***simple*** API to create both line and scatter plots. In general the API avoids subclassing, in an effort to minimize the API surface area, which hopefully contributes to the ease of use of the API.

For detailed descriptions about the background behind the type of graphs you can create, see [Wikipedia line plot][line] page, and the [Wikipedia scatter plot][scatter] page.

> Checkout [Graph Defined][definitions] for a more thourough description about the different types of graphs, which will give you a better understanding of whats provided here.

**Note:** This library is released under the [Apache 2.0 license][license].

  [line]: https://en.wikipedia.org/wiki/Line_chart "Line Plot"
  [scatter]: https://en.wikipedia.org/wiki/Scatter_plot "Scatter Plot"
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

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc elementum, sem fermentum pretium facilisis, metus lacus aliquam augue, ac varius dui elit vulputate leo. Etiam laoreet lacus eu orci lacinia, eu varius erat elementum. Phasellus eros erat, ultrices ut hendrerit vitae, porta nec mi. Aenean malesuada, metus a convallis lacinia, ex nulla posuere nibh, ut sollicitudin mi orci sed purus. Aliquam sodales magna nec odio consectetur pellentesque. Morbi ut lacus consequat leo facilisis interdum. Etiam bibendum nibh non dolor consectetur, eu posuere tortor varius. Proin non euismod eros, commodo tincidunt dui. Duis purus lacus, congue ullamcorper mattis eget, tristique ac nulla. Vestibulum dapibus eleifend malesuada. Vivamus tincidunt dolor diam, sit amet suscipit neque molestie eu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras sed accumsan urna. Nunc nec elit nulla. Aenean tincidunt pellentesque libero at mollis. Donec et sem congue, mattis lorem a, sodales lorem.

Nam ligula lorem, tristique sit amet erat vitae, egestas ultrices arcu. Integer hendrerit, metus eu sagittis pretium, nibh lacus aliquet enim, eu finibus neque massa sed sapien. Maecenas tempus eleifend libero, quis cursus lorem pellentesque quis. Morbi finibus massa eu augue bibendum, ac gravida arcu lobortis. Nulla pellentesque nulla eget porta tincidunt. Ut euismod consectetur consequat. Donec elementum viverra eleifend. Sed sed mollis erat. Suspendisse ultrices, nisl ut fringilla aliquam, velit nunc fermentum est, ac pulvinar massa lacus at elit. Phasellus lorem magna, vulputate non molestie quis, lacinia eu justo.

Nullam ac lacinia ante. Nullam nec dolor nec libero sodales euismod. Etiam non suscipit turpis, id mattis felis. Aenean non ligula lacus. Cras accumsan sem fringilla consequat finibus. Phasellus turpis justo, viverra id diam pulvinar, pretium volutpat lacus. Phasellus consectetur eros sed nulla tempor dapibus. Pellentesque lacinia, felis sed mollis imperdiet, ex velit convallis arcu, non molestie lacus nisl vel leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum nisl est, elementum eget commodo at, vehicula vel purus. Vivamus pellentesque in metus a suscipit. Nulla facilisi. Ut suscipit pharetra ante, vel rutrum mauris varius et.

Mauris vestibulum scelerisque purus sit amet semper. Etiam egestas, nibh ac egestas euismod, dolor erat rhoncus arcu, nec iaculis quam ligula et quam. Vivamus ac facilisis eros, vel porta nibh. Fusce eleifend vulputate efficitur. In vulputate, mauris id dignissim condimentum, dui massa pharetra quam, ac ullamcorper enim ex eu massa. Ut posuere eros id porta aliquet. Cras nulla nisl, posuere eu orci eget, tincidunt interdum ante. Nam faucibus iaculis imperdiet. Curabitur nunc metus, sodales a odio sit amet, porttitor pellentesque neque. Proin id porttitor erat. Donec porta faucibus rhoncus. In finibus nisi interdum lobortis venenatis. Nullam cursus non diam quis aliquet. Morbi laoreet semper augue, at molestie massa. Maecenas in ante nibh. Quisque accumsan ligula felis, dictum suscipit velit sodales sit amet.

Aenean auctor nibh in eros sagittis dignissim. Vestibulum ullamcorper aliquam ante eget lacinia. Curabitur hendrerit sit amet erat at dapibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce eu mi ac lacus eleifend viverra pulvinar ut nisl. Quisque pretium lorem vel turpis aliquet, sed scelerisque ante commodo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare vestibulum ultricies. Praesent commodo vel nisl in scelerisque. Nunc vestibulum volutpat porta. Nunc bibendum dui ut neque ultricies, vitae ultricies libero lacinia. Phasellus nec cursus magna. Nulla sit amet ante pellentesque, gravida dui vel, facilisis urna.

#### Create a line plot

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc elementum, sem fermentum pretium facilisis, metus lacus aliquam augue, ac varius dui elit vulputate leo. Etiam laoreet lacus eu orci lacinia, eu varius erat elementum. Phasellus eros erat, ultrices ut hendrerit vitae, porta nec mi. Aenean malesuada, metus a convallis lacinia, ex nulla posuere nibh, ut sollicitudin mi orci sed purus. Aliquam sodales magna nec odio consectetur pellentesque. Morbi ut lacus consequat leo facilisis interdum. Etiam bibendum nibh non dolor consectetur, eu posuere tortor varius. Proin non euismod eros, commodo tincidunt dui. Duis purus lacus, congue ullamcorper mattis eget, tristique ac nulla. Vestibulum dapibus eleifend malesuada. Vivamus tincidunt dolor diam, sit amet suscipit neque molestie eu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras sed accumsan urna. Nunc nec elit nulla. Aenean tincidunt pellentesque libero at mollis. Donec et sem congue, mattis lorem a, sodales lorem.

Nam ligula lorem, tristique sit amet erat vitae, egestas ultrices arcu. Integer hendrerit, metus eu sagittis pretium, nibh lacus aliquet enim, eu finibus neque massa sed sapien. Maecenas tempus eleifend libero, quis cursus lorem pellentesque quis. Morbi finibus massa eu augue bibendum, ac gravida arcu lobortis. Nulla pellentesque nulla eget porta tincidunt. Ut euismod consectetur consequat. Donec elementum viverra eleifend. Sed sed mollis erat. Suspendisse ultrices, nisl ut fringilla aliquam, velit nunc fermentum est, ac pulvinar massa lacus at elit. Phasellus lorem magna, vulputate non molestie quis, lacinia eu justo.

Nullam ac lacinia ante. Nullam nec dolor nec libero sodales euismod. Etiam non suscipit turpis, id mattis felis. Aenean non ligula lacus. Cras accumsan sem fringilla consequat finibus. Phasellus turpis justo, viverra id diam pulvinar, pretium volutpat lacus. Phasellus consectetur eros sed nulla tempor dapibus. Pellentesque lacinia, felis sed mollis imperdiet, ex velit convallis arcu, non molestie lacus nisl vel leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum nisl est, elementum eget commodo at, vehicula vel purus. Vivamus pellentesque in metus a suscipit. Nulla facilisi. Ut suscipit pharetra ante, vel rutrum mauris varius et.

Mauris vestibulum scelerisque purus sit amet semper. Etiam egestas, nibh ac egestas euismod, dolor erat rhoncus arcu, nec iaculis quam ligula et quam. Vivamus ac facilisis eros, vel porta nibh. Fusce eleifend vulputate efficitur. In vulputate, mauris id dignissim condimentum, dui massa pharetra quam, ac ullamcorper enim ex eu massa. Ut posuere eros id porta aliquet. Cras nulla nisl, posuere eu orci eget, tincidunt interdum ante. Nam faucibus iaculis imperdiet. Curabitur nunc metus, sodales a odio sit amet, porttitor pellentesque neque. Proin id porttitor erat. Donec porta faucibus rhoncus. In finibus nisi interdum lobortis venenatis. Nullam cursus non diam quis aliquet. Morbi laoreet semper augue, at molestie massa. Maecenas in ante nibh. Quisque accumsan ligula felis, dictum suscipit velit sodales sit amet.

Aenean auctor nibh in eros sagittis dignissim. Vestibulum ullamcorper aliquam ante eget lacinia. Curabitur hendrerit sit amet erat at dapibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce eu mi ac lacus eleifend viverra pulvinar ut nisl. Quisque pretium lorem vel turpis aliquet, sed scelerisque ante commodo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare vestibulum ultricies. Praesent commodo vel nisl in scelerisque. Nunc vestibulum volutpat porta. Nunc bibendum dui ut neque ultricies, vitae ultricies libero lacinia. Phasellus nec cursus magna. Nulla sit amet ante pellentesque, gravida dui vel, facilisis urna.

#### Multiple line plots

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc elementum, sem fermentum pretium facilisis, metus lacus aliquam augue, ac varius dui elit vulputate leo. Etiam laoreet lacus eu orci lacinia, eu varius erat elementum. Phasellus eros erat, ultrices ut hendrerit vitae, porta nec mi. Aenean malesuada, metus a convallis lacinia, ex nulla posuere nibh, ut sollicitudin mi orci sed purus. Aliquam sodales magna nec odio consectetur pellentesque. Morbi ut lacus consequat leo facilisis interdum. Etiam bibendum nibh non dolor consectetur, eu posuere tortor varius. Proin non euismod eros, commodo tincidunt dui. Duis purus lacus, congue ullamcorper mattis eget, tristique ac nulla. Vestibulum dapibus eleifend malesuada. Vivamus tincidunt dolor diam, sit amet suscipit neque molestie eu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras sed accumsan urna. Nunc nec elit nulla. Aenean tincidunt pellentesque libero at mollis. Donec et sem congue, mattis lorem a, sodales lorem.

Nam ligula lorem, tristique sit amet erat vitae, egestas ultrices arcu. Integer hendrerit, metus eu sagittis pretium, nibh lacus aliquet enim, eu finibus neque massa sed sapien. Maecenas tempus eleifend libero, quis cursus lorem pellentesque quis. Morbi finibus massa eu augue bibendum, ac gravida arcu lobortis. Nulla pellentesque nulla eget porta tincidunt. Ut euismod consectetur consequat. Donec elementum viverra eleifend. Sed sed mollis erat. Suspendisse ultrices, nisl ut fringilla aliquam, velit nunc fermentum est, ac pulvinar massa lacus at elit. Phasellus lorem magna, vulputate non molestie quis, lacinia eu justo.

Nullam ac lacinia ante. Nullam nec dolor nec libero sodales euismod. Etiam non suscipit turpis, id mattis felis. Aenean non ligula lacus. Cras accumsan sem fringilla consequat finibus. Phasellus turpis justo, viverra id diam pulvinar, pretium volutpat lacus. Phasellus consectetur eros sed nulla tempor dapibus. Pellentesque lacinia, felis sed mollis imperdiet, ex velit convallis arcu, non molestie lacus nisl vel leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum nisl est, elementum eget commodo at, vehicula vel purus. Vivamus pellentesque in metus a suscipit. Nulla facilisi. Ut suscipit pharetra ante, vel rutrum mauris varius et.

Mauris vestibulum scelerisque purus sit amet semper. Etiam egestas, nibh ac egestas euismod, dolor erat rhoncus arcu, nec iaculis quam ligula et quam. Vivamus ac facilisis eros, vel porta nibh. Fusce eleifend vulputate efficitur. In vulputate, mauris id dignissim condimentum, dui massa pharetra quam, ac ullamcorper enim ex eu massa. Ut posuere eros id porta aliquet. Cras nulla nisl, posuere eu orci eget, tincidunt interdum ante. Nam faucibus iaculis imperdiet. Curabitur nunc metus, sodales a odio sit amet, porttitor pellentesque neque. Proin id porttitor erat. Donec porta faucibus rhoncus. In finibus nisi interdum lobortis venenatis. Nullam cursus non diam quis aliquet. Morbi laoreet semper augue, at molestie massa. Maecenas in ante nibh. Quisque accumsan ligula felis, dictum suscipit velit sodales sit amet.

Aenean auctor nibh in eros sagittis dignissim. Vestibulum ullamcorper aliquam ante eget lacinia. Curabitur hendrerit sit amet erat at dapibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce eu mi ac lacus eleifend viverra pulvinar ut nisl. Quisque pretium lorem vel turpis aliquet, sed scelerisque ante commodo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare vestibulum ultricies. Praesent commodo vel nisl in scelerisque. Nunc vestibulum volutpat porta. Nunc bibendum dui ut neque ultricies, vitae ultricies libero lacinia. Phasellus nec cursus magna. Nulla sit amet ante pellentesque, gravida dui vel, facilisis urna.

#### Create a line plot using XYData

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc elementum, sem fermentum pretium facilisis, metus lacus aliquam augue, ac varius dui elit vulputate leo. Etiam laoreet lacus eu orci lacinia, eu varius erat elementum. Phasellus eros erat, ultrices ut hendrerit vitae, porta nec mi. Aenean malesuada, metus a convallis lacinia, ex nulla posuere nibh, ut sollicitudin mi orci sed purus. Aliquam sodales magna nec odio consectetur pellentesque. Morbi ut lacus consequat leo facilisis interdum. Etiam bibendum nibh non dolor consectetur, eu posuere tortor varius. Proin non euismod eros, commodo tincidunt dui. Duis purus lacus, congue ullamcorper mattis eget, tristique ac nulla. Vestibulum dapibus eleifend malesuada. Vivamus tincidunt dolor diam, sit amet suscipit neque molestie eu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras sed accumsan urna. Nunc nec elit nulla. Aenean tincidunt pellentesque libero at mollis. Donec et sem congue, mattis lorem a, sodales lorem.

Nam ligula lorem, tristique sit amet erat vitae, egestas ultrices arcu. Integer hendrerit, metus eu sagittis pretium, nibh lacus aliquet enim, eu finibus neque massa sed sapien. Maecenas tempus eleifend libero, quis cursus lorem pellentesque quis. Morbi finibus massa eu augue bibendum, ac gravida arcu lobortis. Nulla pellentesque nulla eget porta tincidunt. Ut euismod consectetur consequat. Donec elementum viverra eleifend. Sed sed mollis erat. Suspendisse ultrices, nisl ut fringilla aliquam, velit nunc fermentum est, ac pulvinar massa lacus at elit. Phasellus lorem magna, vulputate non molestie quis, lacinia eu justo.

Nullam ac lacinia ante. Nullam nec dolor nec libero sodales euismod. Etiam non suscipit turpis, id mattis felis. Aenean non ligula lacus. Cras accumsan sem fringilla consequat finibus. Phasellus turpis justo, viverra id diam pulvinar, pretium volutpat lacus. Phasellus consectetur eros sed nulla tempor dapibus. Pellentesque lacinia, felis sed mollis imperdiet, ex velit convallis arcu, non molestie lacus nisl vel leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum nisl est, elementum eget commodo at, vehicula vel purus. Vivamus pellentesque in metus a suscipit. Nulla facilisi. Ut suscipit pharetra ante, vel rutrum mauris varius et.

Mauris vestibulum scelerisque purus sit amet semper. Etiam egestas, nibh ac egestas euismod, dolor erat rhoncus arcu, nec iaculis quam ligula et quam. Vivamus ac facilisis eros, vel porta nibh. Fusce eleifend vulputate efficitur. In vulputate, mauris id dignissim condimentum, dui massa pharetra quam, ac ullamcorper enim ex eu massa. Ut posuere eros id porta aliquet. Cras nulla nisl, posuere eu orci eget, tincidunt interdum ante. Nam faucibus iaculis imperdiet. Curabitur nunc metus, sodales a odio sit amet, porttitor pellentesque neque. Proin id porttitor erat. Donec porta faucibus rhoncus. In finibus nisi interdum lobortis venenatis. Nullam cursus non diam quis aliquet. Morbi laoreet semper augue, at molestie massa. Maecenas in ante nibh. Quisque accumsan ligula felis, dictum suscipit velit sodales sit amet.

Aenean auctor nibh in eros sagittis dignissim. Vestibulum ullamcorper aliquam ante eget lacinia. Curabitur hendrerit sit amet erat at dapibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce eu mi ac lacus eleifend viverra pulvinar ut nisl. Quisque pretium lorem vel turpis aliquet, sed scelerisque ante commodo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare vestibulum ultricies. Praesent commodo vel nisl in scelerisque. Nunc vestibulum volutpat porta. Nunc bibendum dui ut neque ultricies, vitae ultricies libero lacinia. Phasellus nec cursus magna. Nulla sit amet ante pellentesque, gravida dui vel, facilisis urna.

#### Create a LinePlot using a function

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc elementum, sem fermentum pretium facilisis, metus lacus aliquam augue, ac varius dui elit vulputate leo. Etiam laoreet lacus eu orci lacinia, eu varius erat elementum. Phasellus eros erat, ultrices ut hendrerit vitae, porta nec mi. Aenean malesuada, metus a convallis lacinia, ex nulla posuere nibh, ut sollicitudin mi orci sed purus. Aliquam sodales magna nec odio consectetur pellentesque. Morbi ut lacus consequat leo facilisis interdum. Etiam bibendum nibh non dolor consectetur, eu posuere tortor varius. Proin non euismod eros, commodo tincidunt dui. Duis purus lacus, congue ullamcorper mattis eget, tristique ac nulla. Vestibulum dapibus eleifend malesuada. Vivamus tincidunt dolor diam, sit amet suscipit neque molestie eu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras sed accumsan urna. Nunc nec elit nulla. Aenean tincidunt pellentesque libero at mollis. Donec et sem congue, mattis lorem a, sodales lorem.

Nam ligula lorem, tristique sit amet erat vitae, egestas ultrices arcu. Integer hendrerit, metus eu sagittis pretium, nibh lacus aliquet enim, eu finibus neque massa sed sapien. Maecenas tempus eleifend libero, quis cursus lorem pellentesque quis. Morbi finibus massa eu augue bibendum, ac gravida arcu lobortis. Nulla pellentesque nulla eget porta tincidunt. Ut euismod consectetur consequat. Donec elementum viverra eleifend. Sed sed mollis erat. Suspendisse ultrices, nisl ut fringilla aliquam, velit nunc fermentum est, ac pulvinar massa lacus at elit. Phasellus lorem magna, vulputate non molestie quis, lacinia eu justo.

Nullam ac lacinia ante. Nullam nec dolor nec libero sodales euismod. Etiam non suscipit turpis, id mattis felis. Aenean non ligula lacus. Cras accumsan sem fringilla consequat finibus. Phasellus turpis justo, viverra id diam pulvinar, pretium volutpat lacus. Phasellus consectetur eros sed nulla tempor dapibus. Pellentesque lacinia, felis sed mollis imperdiet, ex velit convallis arcu, non molestie lacus nisl vel leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum nisl est, elementum eget commodo at, vehicula vel purus. Vivamus pellentesque in metus a suscipit. Nulla facilisi. Ut suscipit pharetra ante, vel rutrum mauris varius et.

Mauris vestibulum scelerisque purus sit amet semper. Etiam egestas, nibh ac egestas euismod, dolor erat rhoncus arcu, nec iaculis quam ligula et quam. Vivamus ac facilisis eros, vel porta nibh. Fusce eleifend vulputate efficitur. In vulputate, mauris id dignissim condimentum, dui massa pharetra quam, ac ullamcorper enim ex eu massa. Ut posuere eros id porta aliquet. Cras nulla nisl, posuere eu orci eget, tincidunt interdum ante. Nam faucibus iaculis imperdiet. Curabitur nunc metus, sodales a odio sit amet, porttitor pellentesque neque. Proin id porttitor erat. Donec porta faucibus rhoncus. In finibus nisi interdum lobortis venenatis. Nullam cursus non diam quis aliquet. Morbi laoreet semper augue, at molestie massa. Maecenas in ante nibh. Quisque accumsan ligula felis, dictum suscipit velit sodales sit amet.

Aenean auctor nibh in eros sagittis dignissim. Vestibulum ullamcorper aliquam ante eget lacinia. Curabitur hendrerit sit amet erat at dapibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce eu mi ac lacus eleifend viverra pulvinar ut nisl. Quisque pretium lorem vel turpis aliquet, sed scelerisque ante commodo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare vestibulum ultricies. Praesent commodo vel nisl in scelerisque. Nunc vestibulum volutpat porta. Nunc bibendum dui ut neque ultricies, vitae ultricies libero lacinia. Phasellus nec cursus magna. Nulla sit amet ante pellentesque, gravida dui vel, facilisis urna.

### Scatter plots

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc elementum, sem fermentum pretium facilisis, metus lacus aliquam augue, ac varius dui elit vulputate leo. Etiam laoreet lacus eu orci lacinia, eu varius erat elementum. Phasellus eros erat, ultrices ut hendrerit vitae, porta nec mi. Aenean malesuada, metus a convallis lacinia, ex nulla posuere nibh, ut sollicitudin mi orci sed purus. Aliquam sodales magna nec odio consectetur pellentesque. Morbi ut lacus consequat leo facilisis interdum. Etiam bibendum nibh non dolor consectetur, eu posuere tortor varius. Proin non euismod eros, commodo tincidunt dui. Duis purus lacus, congue ullamcorper mattis eget, tristique ac nulla. Vestibulum dapibus eleifend malesuada. Vivamus tincidunt dolor diam, sit amet suscipit neque molestie eu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras sed accumsan urna. Nunc nec elit nulla. Aenean tincidunt pellentesque libero at mollis. Donec et sem congue, mattis lorem a, sodales lorem.

Nam ligula lorem, tristique sit amet erat vitae, egestas ultrices arcu. Integer hendrerit, metus eu sagittis pretium, nibh lacus aliquet enim, eu finibus neque massa sed sapien. Maecenas tempus eleifend libero, quis cursus lorem pellentesque quis. Morbi finibus massa eu augue bibendum, ac gravida arcu lobortis. Nulla pellentesque nulla eget porta tincidunt. Ut euismod consectetur consequat. Donec elementum viverra eleifend. Sed sed mollis erat. Suspendisse ultrices, nisl ut fringilla aliquam, velit nunc fermentum est, ac pulvinar massa lacus at elit. Phasellus lorem magna, vulputate non molestie quis, lacinia eu justo.

Nullam ac lacinia ante. Nullam nec dolor nec libero sodales euismod. Etiam non suscipit turpis, id mattis felis. Aenean non ligula lacus. Cras accumsan sem fringilla consequat finibus. Phasellus turpis justo, viverra id diam pulvinar, pretium volutpat lacus. Phasellus consectetur eros sed nulla tempor dapibus. Pellentesque lacinia, felis sed mollis imperdiet, ex velit convallis arcu, non molestie lacus nisl vel leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum nisl est, elementum eget commodo at, vehicula vel purus. Vivamus pellentesque in metus a suscipit. Nulla facilisi. Ut suscipit pharetra ante, vel rutrum mauris varius et.

Mauris vestibulum scelerisque purus sit amet semper. Etiam egestas, nibh ac egestas euismod, dolor erat rhoncus arcu, nec iaculis quam ligula et quam. Vivamus ac facilisis eros, vel porta nibh. Fusce eleifend vulputate efficitur. In vulputate, mauris id dignissim condimentum, dui massa pharetra quam, ac ullamcorper enim ex eu massa. Ut posuere eros id porta aliquet. Cras nulla nisl, posuere eu orci eget, tincidunt interdum ante. Nam faucibus iaculis imperdiet. Curabitur nunc metus, sodales a odio sit amet, porttitor pellentesque neque. Proin id porttitor erat. Donec porta faucibus rhoncus. In finibus nisi interdum lobortis venenatis. Nullam cursus non diam quis aliquet. Morbi laoreet semper augue, at molestie massa. Maecenas in ante nibh. Quisque accumsan ligula felis, dictum suscipit velit sodales sit amet.

Aenean auctor nibh in eros sagittis dignissim. Vestibulum ullamcorper aliquam ante eget lacinia. Curabitur hendrerit sit amet erat at dapibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce eu mi ac lacus eleifend viverra pulvinar ut nisl. Quisque pretium lorem vel turpis aliquet, sed scelerisque ante commodo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare vestibulum ultricies. Praesent commodo vel nisl in scelerisque. Nunc vestibulum volutpat porta. Nunc bibendum dui ut neque ultricies, vitae ultricies libero lacinia. Phasellus nec cursus magna. Nulla sit amet ante pellentesque, gravida dui vel, facilisis urna.

#### Create a ScatterPlot with shape Symbols

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc elementum, sem fermentum pretium facilisis, metus lacus aliquam augue, ac varius dui elit vulputate leo. Etiam laoreet lacus eu orci lacinia, eu varius erat elementum. Phasellus eros erat, ultrices ut hendrerit vitae, porta nec mi. Aenean malesuada, metus a convallis lacinia, ex nulla posuere nibh, ut sollicitudin mi orci sed purus. Aliquam sodales magna nec odio consectetur pellentesque. Morbi ut lacus consequat leo facilisis interdum. Etiam bibendum nibh non dolor consectetur, eu posuere tortor varius. Proin non euismod eros, commodo tincidunt dui. Duis purus lacus, congue ullamcorper mattis eget, tristique ac nulla. Vestibulum dapibus eleifend malesuada. Vivamus tincidunt dolor diam, sit amet suscipit neque molestie eu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras sed accumsan urna. Nunc nec elit nulla. Aenean tincidunt pellentesque libero at mollis. Donec et sem congue, mattis lorem a, sodales lorem.

Nam ligula lorem, tristique sit amet erat vitae, egestas ultrices arcu. Integer hendrerit, metus eu sagittis pretium, nibh lacus aliquet enim, eu finibus neque massa sed sapien. Maecenas tempus eleifend libero, quis cursus lorem pellentesque quis. Morbi finibus massa eu augue bibendum, ac gravida arcu lobortis. Nulla pellentesque nulla eget porta tincidunt. Ut euismod consectetur consequat. Donec elementum viverra eleifend. Sed sed mollis erat. Suspendisse ultrices, nisl ut fringilla aliquam, velit nunc fermentum est, ac pulvinar massa lacus at elit. Phasellus lorem magna, vulputate non molestie quis, lacinia eu justo.

Nullam ac lacinia ante. Nullam nec dolor nec libero sodales euismod. Etiam non suscipit turpis, id mattis felis. Aenean non ligula lacus. Cras accumsan sem fringilla consequat finibus. Phasellus turpis justo, viverra id diam pulvinar, pretium volutpat lacus. Phasellus consectetur eros sed nulla tempor dapibus. Pellentesque lacinia, felis sed mollis imperdiet, ex velit convallis arcu, non molestie lacus nisl vel leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum nisl est, elementum eget commodo at, vehicula vel purus. Vivamus pellentesque in metus a suscipit. Nulla facilisi. Ut suscipit pharetra ante, vel rutrum mauris varius et.

Mauris vestibulum scelerisque purus sit amet semper. Etiam egestas, nibh ac egestas euismod, dolor erat rhoncus arcu, nec iaculis quam ligula et quam. Vivamus ac facilisis eros, vel porta nibh. Fusce eleifend vulputate efficitur. In vulputate, mauris id dignissim condimentum, dui massa pharetra quam, ac ullamcorper enim ex eu massa. Ut posuere eros id porta aliquet. Cras nulla nisl, posuere eu orci eget, tincidunt interdum ante. Nam faucibus iaculis imperdiet. Curabitur nunc metus, sodales a odio sit amet, porttitor pellentesque neque. Proin id porttitor erat. Donec porta faucibus rhoncus. In finibus nisi interdum lobortis venenatis. Nullam cursus non diam quis aliquet. Morbi laoreet semper augue, at molestie massa. Maecenas in ante nibh. Quisque accumsan ligula felis, dictum suscipit velit sodales sit amet.

Aenean auctor nibh in eros sagittis dignissim. Vestibulum ullamcorper aliquam ante eget lacinia. Curabitur hendrerit sit amet erat at dapibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce eu mi ac lacus eleifend viverra pulvinar ut nisl. Quisque pretium lorem vel turpis aliquet, sed scelerisque ante commodo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare vestibulum ultricies. Praesent commodo vel nisl in scelerisque. Nunc vestibulum volutpat porta. Nunc bibendum dui ut neque ultricies, vitae ultricies libero lacinia. Phasellus nec cursus magna. Nulla sit amet ante pellentesque, gravida dui vel, facilisis urna.

#### Create a ScatterPlot with image Symbols

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc elementum, sem fermentum pretium facilisis, metus lacus aliquam augue, ac varius dui elit vulputate leo. Etiam laoreet lacus eu orci lacinia, eu varius erat elementum. Phasellus eros erat, ultrices ut hendrerit vitae, porta nec mi. Aenean malesuada, metus a convallis lacinia, ex nulla posuere nibh, ut sollicitudin mi orci sed purus. Aliquam sodales magna nec odio consectetur pellentesque. Morbi ut lacus consequat leo facilisis interdum. Etiam bibendum nibh non dolor consectetur, eu posuere tortor varius. Proin non euismod eros, commodo tincidunt dui. Duis purus lacus, congue ullamcorper mattis eget, tristique ac nulla. Vestibulum dapibus eleifend malesuada. Vivamus tincidunt dolor diam, sit amet suscipit neque molestie eu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras sed accumsan urna. Nunc nec elit nulla. Aenean tincidunt pellentesque libero at mollis. Donec et sem congue, mattis lorem a, sodales lorem.

Nam ligula lorem, tristique sit amet erat vitae, egestas ultrices arcu. Integer hendrerit, metus eu sagittis pretium, nibh lacus aliquet enim, eu finibus neque massa sed sapien. Maecenas tempus eleifend libero, quis cursus lorem pellentesque quis. Morbi finibus massa eu augue bibendum, ac gravida arcu lobortis. Nulla pellentesque nulla eget porta tincidunt. Ut euismod consectetur consequat. Donec elementum viverra eleifend. Sed sed mollis erat. Suspendisse ultrices, nisl ut fringilla aliquam, velit nunc fermentum est, ac pulvinar massa lacus at elit. Phasellus lorem magna, vulputate non molestie quis, lacinia eu justo.

Nullam ac lacinia ante. Nullam nec dolor nec libero sodales euismod. Etiam non suscipit turpis, id mattis felis. Aenean non ligula lacus. Cras accumsan sem fringilla consequat finibus. Phasellus turpis justo, viverra id diam pulvinar, pretium volutpat lacus. Phasellus consectetur eros sed nulla tempor dapibus. Pellentesque lacinia, felis sed mollis imperdiet, ex velit convallis arcu, non molestie lacus nisl vel leo. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum nisl est, elementum eget commodo at, vehicula vel purus. Vivamus pellentesque in metus a suscipit. Nulla facilisi. Ut suscipit pharetra ante, vel rutrum mauris varius et.

Mauris vestibulum scelerisque purus sit amet semper. Etiam egestas, nibh ac egestas euismod, dolor erat rhoncus arcu, nec iaculis quam ligula et quam. Vivamus ac facilisis eros, vel porta nibh. Fusce eleifend vulputate efficitur. In vulputate, mauris id dignissim condimentum, dui massa pharetra quam, ac ullamcorper enim ex eu massa. Ut posuere eros id porta aliquet. Cras nulla nisl, posuere eu orci eget, tincidunt interdum ante. Nam faucibus iaculis imperdiet. Curabitur nunc metus, sodales a odio sit amet, porttitor pellentesque neque. Proin id porttitor erat. Donec porta faucibus rhoncus. In finibus nisi interdum lobortis venenatis. Nullam cursus non diam quis aliquet. Morbi laoreet semper augue, at molestie massa. Maecenas in ante nibh. Quisque accumsan ligula felis, dictum suscipit velit sodales sit amet.

Aenean auctor nibh in eros sagittis dignissim. Vestibulum ullamcorper aliquam ante eget lacinia. Curabitur hendrerit sit amet erat at dapibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce eu mi ac lacus eleifend viverra pulvinar ut nisl. Quisque pretium lorem vel turpis aliquet, sed scelerisque ante commodo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare vestibulum ultricies. Praesent commodo vel nisl in scelerisque. Nunc vestibulum volutpat porta. Nunc bibendum dui ut neque ultricies, vitae ultricies libero lacinia. Phasellus nec cursus magna. Nulla sit amet ante pellentesque, gravida dui vel, facilisis urna.
