import SwiftUI

/// Modular `Grid` style.
public struct ModularGridStyle: GridStyle, Equatable {
    public var columns: Tracks
    public var rows: Tracks
    public var axis: Axis
    public var spacing: CGFloat
    public var autoWidth: Bool = true
    public var autoHeight: Bool = true
        
    public init(_ axis: Axis = .vertical, columns: Tracks, rows: Tracks, spacing: CGFloat = 8) {
        self.columns = columns
        self.rows = rows
        self.axis = axis
        self.spacing = spacing
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        ModularGridStyleView(style: self, items: configuration.items)
    }
    
    public func transform(preferences: inout GridPreferences, in size: CGSize) {
        let computedTracksCount = self.axis == .vertical ?
            tracksCount(
                tracks: self.columns,
                spacing: self.spacing,
                availableLength: size.width
            ) :
            tracksCount(
                tracks: self.rows,
                spacing: self.spacing,
                availableLength: size.height
            )
        
        let itemSize = CGSize(
            width: itemLength(
                tracks: self.columns,
                spacing: self.spacing,
                availableLength: size.width
            ),
            height: itemLength(
                tracks: self.rows,
                spacing: self.spacing,
                availableLength: size.height
            )
        )
        
        preferences = layoutPreferences(
            tracks: computedTracksCount,
            spacing: self.spacing,
            axis: self.axis,
            itemSize: itemSize,
            preferences: preferences
        )
    }
    
    private func layoutPreferences(tracks: Int, spacing: CGFloat, axis: Axis, itemSize: CGSize, preferences: GridPreferences) -> GridPreferences {
        var tracksLengths = Array(repeating: CGFloat(0.0), count: tracks)
        var newPreferences: GridPreferences = GridPreferences(items: [])
        
        preferences.items.forEach { preference in
            if let minValue = tracksLengths.min(), let indexMin = tracksLengths.firstIndex(of: minValue) {
                let itemSizeWidth = itemSize.width
                let itemSizeHeight = itemSize.height
                let width = axis == .vertical ? itemSizeWidth * CGFloat(indexMin) + CGFloat(indexMin) * spacing : tracksLengths[indexMin]
                let height = axis == .vertical ? tracksLengths[indexMin] : itemSizeHeight * CGFloat(indexMin) + CGFloat(indexMin) * spacing
        
                let origin = CGPoint(x: width, y: height)
                tracksLengths[indexMin] += (axis == .vertical ? itemSizeHeight : itemSizeWidth) + spacing
                
                newPreferences.merge(with:
                    GridPreferences(items: [GridPreferences.Item(
                        id: preference.id,
                        bounds: CGRect(origin: origin, size: CGSize(width: itemSizeWidth, height: itemSizeHeight))
                    )])
                )
            }
        }

        return newPreferences
    }
}


private struct ModularGridStyleView: View {
    let style: ModularGridStyle
    @State var preferences: GridPreferences = GridPreferences(size: .zero, items: [])
    let items: [GridItem]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(self.items) { item in
                    item.view
                        .frame(
                            width: self.style.autoWidth ? self.preferences[item.id]?.bounds.width : nil,
                            height: self.style.autoHeight ? self.preferences[item.id]?.bounds.height : nil
                        )
                        .alignmentGuide(.leading, computeValue: { _ in geometry.size.width - (self.preferences[item.id]?.bounds.origin.x ?? 0) })
                        .alignmentGuide(.top, computeValue: { _ in geometry.size.height - (self.preferences[item.id]?.bounds.origin.y ?? 0) })
                        .background(GridPreferencesModifier(id: item.id, bounds: self.preferences[item.id]?.bounds ?? .zero))
                        .anchorPreference(key: GridItemBoundsPreferencesKey.self, value: .bounds) { [geometry[$0]] }
                }
            }
            .transformPreference(GridPreferencesKey.self) {
                self.style.transform(preferences: &$0, in: geometry.size)
            }
        }
        .frame(
            width: self.style.axis == .horizontal ? self.preferences.size.width : nil,
            height: self.style.axis == .vertical ? self.preferences.size.height : nil,
            alignment: .topLeading
        )
        .onPreferenceChange(GridPreferencesKey.self) { preferences in
            self.preferences = preferences
        }
    }
}
