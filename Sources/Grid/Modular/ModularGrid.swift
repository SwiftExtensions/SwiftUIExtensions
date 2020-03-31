import SwiftUI

struct ModularGrid: View {
    @State var preferences: GridPreferences = GridPreferences(size: .zero, items: [])
    let items: [GridItem]
    var columns: Tracks
    var rows: Tracks
    var axis: Axis
    var spacing: CGFloat
    var autoWidth: Bool = true
    var autoHeight: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(self.items) { item in
                    item.view
                        .frame(
                            width: self.autoWidth ? self.preferences[item.id]?.bounds.width : nil,
                            height: self.autoHeight ? self.preferences[item.id]?.bounds.height : nil
                        )
                        .alignmentGuide(.leading, computeValue: { _ in geometry.size.width - (self.preferences[item.id]?.bounds.origin.x ?? 0) })
                        .alignmentGuide(.top, computeValue: { _ in geometry.size.height - (self.preferences[item.id]?.bounds.origin.y ?? 0) })
                        .background(GridPreferencesModifier(id: item.id, bounds: self.preferences[item.id]?.bounds ?? .zero))
                        .anchorPreference(key: GridItemBoundsPreferencesKey.self, value: .bounds) { [geometry[$0]] }
                }
            }
            .transformPreference(GridPreferencesKey.self) {
                self.transform(preferences: &$0, in: geometry.size)
            }
        }
        .frame(
            minWidth: self.axis == .horizontal ? self.preferences.size.width : nil,
            minHeight: self.axis == .vertical ? self.preferences.size.height : nil,
            alignment: .topLeading
        )
        .onPreferenceChange(GridPreferencesKey.self) { preferences in
            self.preferences = preferences
        }
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
