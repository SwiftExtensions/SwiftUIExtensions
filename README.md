# SwiftUI Grid
SwiftUI Grid view layout with custom styles.

## Features
- ZStack based layout
- Vertical and horizontal scrolling
- Supports all apple platforms
- Custom styles (ModularGridStyle, StaggeredGridStyle)
- SwiftUI code patterns (StyleStructs, EnvironmentValues, ViewBuilder)
- Active development for production apps

Open `/Examples/GridExamples.xcodeproj` for more examples for iOS, macOS, watchOS and tvOS

## Styles

### ModularGridStyle (Default)
<center>
<img src="Resources/iPad1.png"/>
</center>

```swift
Grid(colors) {
    Rectangle()
        .foregroundColor($0)
}
.gridStyle(
    ModularGridStyle(columns: .auto(.min(100)), rows: .auto(.min(100)))
)
```

### StaggeredGridStyle

<center>
<img src="Resources/iPad2.png"/>
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

## Preferences
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

## SDKs
- iOS 13+
- Mac Catalyst 13.0+
- macOS 10.15+
- watchOS 6+
- Xcode 11.0+

## Roadmap
-  Animations
- 'CSS Grid'-like features

## Code Contibutions
Feel free to contribute via fork/pull request to master branch. If you want to request a feature or report a bug please start a new issue.

## Coffee Contibutions
If you find this project useful please consider becoming a sponsor.
