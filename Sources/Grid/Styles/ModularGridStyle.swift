import SwiftUI

/// Staggered `Grid` style.
public struct ModularGridStyle: GridStyle {
    let columns: Tracks
    let rows: Tracks
    let spacing: CGFloat
    public let padding: EdgeInsets
        
    public init(columns: Tracks, rows: Tracks, spacing: CGFloat = 8, padding: EdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)) {
        self.columns = columns
        self.rows = rows
        self.spacing = spacing
        self.padding = padding
    }
    
    public func transform(preferences: inout [GridItemPreferences], in geometry: GeometryProxy) {
        let computedTracksCount = tracksCount(
            tracks: self.columns,
            spacing: self.spacing,
            padding: self.padding.leading + self.padding.trailing,
            availableLength: geometry.size.width
        )
        
        let size = CGSize(
            width: itemLength(
                tracks: self.columns,
                spacing: self.spacing,
                padding: self.padding.leading + self.padding.trailing,
                availableLength: geometry.size.width
            ),
            height: itemLength(
                tracks: self.rows,
                spacing: self.spacing,
                padding: self.padding.top + self.padding.bottom,
                availableLength: geometry.size.height
            )
        )
        
        preferences = gridAlignmentGuides(
            tracks: computedTracksCount,
            spacing: self.spacing,
            axis: .vertical,
            size: size,
            geometry: geometry,
            preferences: preferences
        )
    }
    
    private func gridAlignmentGuides(tracks: Int, spacing: CGFloat, axis: Axis.Set, size: CGSize, geometry: GeometryProxy, preferences: [GridItemPreferences]) -> [GridItemPreferences] {
        var heights = Array(repeating: CGFloat(0), count: tracks)
        var alignmentGuides: [GridItemPreferences] = []
        preferences.forEach { preference in
            if let minValue = heights.min(), let indexMin = heights.firstIndex(of: minValue) {
                //let size = geometry[preference.anchor].size
                let preferenceSizeWidth = axis == .vertical ? size.width : size.height
                let preferenceSizeHeight = axis == .vertical ? size.height : size.width
                let width = preferenceSizeWidth * CGFloat(indexMin) + CGFloat(indexMin) * spacing
                let height = heights[indexMin]
                let offset = CGPoint(
                    x: 0 - (axis == .vertical ? width : height),
                    y: 0 - (axis == .vertical ? height : width)
                )
                heights[indexMin] += preferenceSizeHeight + spacing
                
                alignmentGuides.append(GridItemPreferences(
                    id: preference.id,
                    origin: offset,
                    itemWidth: preferenceSizeWidth,
                    itemHeight: preferenceSizeHeight)
                )
            }
        }

        return alignmentGuides
    }
}
