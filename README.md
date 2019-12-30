# SwiftUI Extensions
Collection of useful SwiftUI extensions and elements

[![Build Status](https://github.com/swift-extensions/swiftui-extensions/workflows/ci/badge.svg)](https://github.com/swift-extensions/swiftui-extensions/actions)

- Grid based layouts
- Sliders (horizontal, vertical, point)
- Custom shapes
- Data charts
- Supports all apple platforms
- SwiftUI code patterns (Styles, EnvironmentValues, ViewBuilder)
- Active development for production apps

Open `/Demo/SwiftUIExtensionsDemo.xcodeproj` for more examples for iOS, macOS, watchOS and tvOS

## Layouts

### Modular Grid
<center>
<img src="Resources/Layouts/modularGrid.png"/>
</center>

```swift
Grid(colors) {
    Rectangle()
        .foregroundColor($0)
}
.gridStyle(
    ModularGridStyle(columns: .min(100), rows: .min(100))
)
```

### Staggered Grid

<center>
<img src="Resources/Layouts/staggeredGrid.png"/>
</center>

```swift
Grid(1...69, id: \.self) { index in
    Image("\(index)")
        .resizable()
        .scaledToFit()
}
.gridStyle(
    StaggeredGridStyle(tracks: 8, axis: .horizontal, spacing: 4)
)
```

#### Tracks
Tracks setting allows you to customize grid behaviour to your specific use-case. Both Modular and Staggered grid use tracks value to calculate layout. In Modular layout both columns and rows are tracks.

```swift
public enum Tracks: Hashable {
    case count(Int)
    case fixed(CGFloat)
    case min(CGFloat)
}
```

##### Count
Grid is split into equal fractions of size provided by a parent view.

```swift
ModularGridStyle(columns: 3, rows: 3)
StaggeredGridStyle(tracks: 8)
```

##### Fixed
Item size is fixed to a specific width or height.
```swift
ModularGridStyle(columns: .fixed(100), rows: .fixed(100))
StaggeredGridStyle(tracks: .fixed(100))
```

##### Min
Autolayout respecting a min item width or height.
```swift
ModularGridStyle(columns: .min(100), rows: .min(100))
StaggeredGridStyle(tracks: .min(100))
```

#### Preferences
Get item size and position with preferences
```swift
struct CardsView: View {
    @State var selection: Int = 0
    
    var body: some View {
        Grid(0..<100) { number in
            Card(title: "\(number)")
                .onTapGesture {
                    self.selection = number
                }
        }
        .padding()
        .overlayPreferenceValue(GridItemBoundsPreferencesKey.self) { preferences in
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(lineWidth: 4)
                .foregroundColor(.white)
                .frame(
                    width: preferences[self.selection].width,
                    height: preferences[self.selection].height
                )
                .position(
                    x: preferences[self.selection].midX,
                    y: preferences[self.selection].midY
                )
                .animation(.linear)
        }
    }
}
```

## Sliders

Highly customizable sliders and tracks

<center>
<img src="Resources/Sliders/sliders.png"/>
</center>

### Simple gradient value slider style
```swift
HSlider(value: $value, track:
    LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
        .frame(height: 8)
        .cornerRadius(4)
)
```

### Multivalue track
```swift
ZStack {
    HTrack(value: value1, view: Capsule().foregroundColor(.red)).opacity(0.5)
    HTrack(value: value2, view: Capsule().foregroundColor(.blue)).opacity(0.5)
    HTrack(value: value3, view: Capsule().foregroundColor(.green)).opacity(0.5)
}
.animation(.spring())
.frame(height: 8)
.background(Color.secondary.opacity(0.25))
```

### Complex range slider style
```swift
HRangeSlider(range: $range, in: 0.0...1.0, step: 0.01,
    track:
        HRangeTrack(
            range: range,
            view: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing),
            mask: Rectangle(),
            configuration: .init(
                offsets: 32
            )
        )
        .background(Color.secondary.opacity(0.25))
        .cornerRadius(16)
        .padding(.vertical, 8)
        .animation(.easeInOut(duration: 0.5)),
    lowerThumb: 
        Capsule()
            .foregroundColor(.white),
    upperThumb:
        Capsule()
            .foregroundColor(.white),
    configuration: .init(
        thumbSize: CGSize(width: 32, height: 64),
        thumbInteractiveSize: CGSize(width: 44, height: 64)
    ),
    onEditingChanged: { print($0) }
)
.frame(height: 64)
```

### Complex point slider style
```swift
XYSlider(x: $x, y: $y,
    track:
        RoundedRectangle(cornerRadius: 24)
            .foregroundColor(
                Color(hue: 0.67, saturation: y, brightness: 1.0)
            ),
    thumb:
        ZStack {
            Capsule().frame(width: 12).foregroundColor(.white)
            Capsule().frame(height: 12).foregroundColor(.white)
        }
        .compositingGroup()
        .rotationEffect(Angle(radians: x * 10))
        .shadow(radius: 3),
    configuration: .init(
        options: .interactiveTrack,
        thumbSize: CGSize(width: 48, height: 48)
    )
)
.frame(height: 256)
.shadow(radius: 3)
.padding()
```

## Data Visualization

Build custom charts with SwiftUI

<center>
<img src="Resources/DataVisualizations/customChart.png"/>
</center>

### Line Chart
<center>
<img src="Resources/DataVisualizations/lineChart.png"/>
</center>

```swift
Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
    .chartStyle(
        LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 5)
    )
```

### Area Chart
<center>
<img src="Resources/DataVisualizations/areaChart.png"/>
</center>

```swift
Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
    .chartStyle(
        AreaChartStyle(.quadCurve, fill:
            LinearGradient(gradient: .init(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.05)]), startPoint: .top, endPoint: .bottom)
        )
    )
```

### Stacked Area Chart

```swift
Chart(data: matrix)
    .chartStyle(
        StackedAreaChartStyle(.quadCurve, colors: [.yellow, .orange, .red])
    )
```

### Column Chart
<center>
<img src="Resources/DataVisualizations/columnChart.png"/>
</center>

```swift
Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
    .chartStyle(
        ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
    )
```

### Stacked Column Chart

```swift
Chart(data: matrix)
    .chartStyle(
        StackedColumnChartStyle(spacing: 2, colors: [.yellow, .orange, .red])
    )
```

## Shapes

### Regular Polygons
<center>
<img src="Resources/Shapes/regularRectangles.png"/>
</center>

```swift
Pentagon()
Hexagon()
RegularPolygon(sides: 32)
```

### Lines and Curves
<center>
<img src="Resources/Shapes/lines.png"/>
</center>

```swift
QuadCurve(unitPoints: [
    UnitPoint(x: 0.1, y: 0.1),
    UnitPoint(x: 0.5, y: 0.9),
    UnitPoint(x: 0.9, y: 0.1)
])
.stroke(Color.blue, style: .init(lineWidth: 2, lineCap: .round))
.frame(height: 200)
```

### Patterns
<center>
<img src="Resources/Shapes/patterns.png"/>
</center>

```swift
GridPattern(horizontalLines: 20, verticalLines: 40)
    .stroke(Color.white.opacity(0.3), style: .init(lineWidth: 1, lineCap: .round))
    .frame(height: 200)
    .background(Color.blue)
    .padding()
```

## SDKs
- iOS 13+
- Mac Catalyst 13.0+
- macOS 10.15+
- watchOS 6+
- Xcode 11.0+

## Roadmap
-  Animations
- 'CSS Grid'-like features for Modular Grid
- View Modifiers
- Rounded regular polygons
- Bar chart style

## Code Contibutions
Feel free to contribute via fork/pull request to master branch. If you want to request a feature or report a bug please start a new issue.

## Coffee Contibutions
If you find this project useful please consider becoming a sponsor.
