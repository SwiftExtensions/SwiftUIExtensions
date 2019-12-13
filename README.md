# SwiftUI Extensions
Collection of useful SwiftUI extensions and elements

- Grid based layouts
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

## Code Contibutions
Feel free to contribute via fork/pull request to master branch. If you want to request a feature or report a bug please start a new issue.

## Coffee Contibutions
If you find this project useful please consider becoming a sponsor.
