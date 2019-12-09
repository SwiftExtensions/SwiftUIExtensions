import SwiftUI

/// Modular `Grid` style.
public struct ModularGridStyle: GridStyle {
    public var columns: Tracks
    public var rows: Tracks
    public var axis: Axis
    public var spacing: CGFloat
    public var padding: EdgeInsets
    public var autoWidth: Bool = true
    public var autoHeight: Bool = true
        
    public init(columns: Tracks, rows: Tracks, axis: Axis = .vertical, spacing: CGFloat = 8, padding: EdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)) {
        self.columns = columns
        self.rows = rows
        self.axis = axis
        self.spacing = spacing
        self.padding = padding
    }
    
    public func transform(preferences: inout [GridItemPreferences], in size: CGSize) {
        let computedTracksCount = self.axis == .vertical ?
            tracksCount(
                tracks: self.columns,
                spacing: self.spacing,
                padding: self.padding.leading + self.padding.trailing,
                availableLength: size.width
            ) :
            tracksCount(
                tracks: self.rows,
                spacing: self.spacing,
                padding: self.padding.top + self.padding.bottom,
                availableLength: size.height
            )
        
        let itemSize = CGSize(
            width: itemLength(
                tracks: self.columns,
                spacing: self.spacing,
                padding: self.padding.leading + self.padding.trailing,
                availableLength: size.width
            ),
            height: itemLength(
                tracks: self.rows,
                spacing: self.spacing,
                padding: self.padding.top + self.padding.bottom,
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
    
    private func layoutPreferences(tracks: Int, spacing: CGFloat, axis: Axis, itemSize: CGSize, preferences: [GridItemPreferences]) -> [GridItemPreferences] {
        var tracksLengths = Array(repeating: CGFloat(0.0), count: tracks)
        var newPreferences: [GridItemPreferences] = []
        
        preferences.forEach { preference in
            if let minValue = tracksLengths.min(), let indexMin = tracksLengths.firstIndex(of: minValue) {
                let itemSizeWidth = itemSize.width
                let itemSizeHeight = itemSize.height
                let width = axis == .vertical ? itemSizeWidth * CGFloat(indexMin) + CGFloat(indexMin) * spacing : tracksLengths[indexMin]
                let height = axis == .vertical ? tracksLengths[indexMin] : itemSizeHeight * CGFloat(indexMin) + CGFloat(indexMin) * spacing
        
                let origin = CGPoint(x: 0 - width, y: 0 - height)
                tracksLengths[indexMin] += (axis == .vertical ? itemSizeHeight : itemSizeWidth) + spacing
                
                newPreferences.append(
                    GridItemPreferences(
                        id: preference.id,
                        bounds: CGRect(origin: origin, size: CGSize(width: itemSizeWidth, height: itemSizeHeight))
                    )
                )
            }
        }

        return newPreferences
    }
}
