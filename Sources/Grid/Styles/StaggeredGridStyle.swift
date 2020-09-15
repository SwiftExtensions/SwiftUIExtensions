import SwiftUI

/// Staggered `Grid` style.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct StaggeredGridStyle: GridStyle {
    public var tracks: Tracks
    public var axis: Axis
    public var spacing: CGFloat
    
    public var autoWidth: Bool {
        axis == .vertical
    }
    public var autoHeight: Bool {
        axis == .horizontal
    }

    public init(_ axis: Axis = .vertical, tracks: Tracks, spacing: CGFloat = 8) {
        self.tracks = tracks
        self.spacing = spacing
        self.axis = axis
    }

    public func transform(preferences: inout GridPreferences, in size: CGSize) {
        let computedTracksCount = self.axis == .vertical ?
            tracksCount(
                tracks: self.tracks,
                spacing: self.spacing,
                availableLength: size.width
            ) :
            tracksCount(
                tracks: self.tracks,
                spacing: self.spacing,
                availableLength: size.height
            )

        let size = CGSize(
            width: itemLength(
                tracks: self.tracks,
                spacing: self.spacing,
                availableLength: size.width
            ),
            height: itemLength(
                tracks: self.tracks,
                spacing: self.spacing,
                availableLength: size.height
            )
        )

        preferences = layoutPreferences(
            tracks: computedTracksCount,
            spacing: self.spacing,
            axis: self.axis,
            itemSize: size,
            preferences: preferences
        )
    }
    
    private func layoutPreferences(tracks: Int, spacing: CGFloat, axis: Axis, itemSize: CGSize, preferences: GridPreferences) -> GridPreferences {
        var tracksLengths = Array(repeating: CGFloat(0.0), count: tracks)
        var newPreferences: GridPreferences = GridPreferences(items: [])
        
        preferences.items.forEach { preference in
            if let minValue = tracksLengths.min(), let indexMin = tracksLengths.firstIndex(of: minValue) {
                let itemSizeWidth = axis == .vertical ? itemSize.width : preference.bounds.size.width
                let itemSizeHeight = axis == .vertical ? preference.bounds.size.height : itemSize.height
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
