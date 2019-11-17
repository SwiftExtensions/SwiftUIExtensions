import SwiftUI

/// Staggered `Grid` style.
public struct StaggeredGridStyle: GridStyle {
    let tracks: Tracks
    public let axis: Axis
    let spacing: CGFloat
    public let padding: EdgeInsets
    
    public var autoWidth: Bool {
        axis == .vertical
    }
    public var autoHeight: Bool {
        axis == .horizontal
    }

    public init(tracks: Tracks, axis: Axis = .vertical, spacing: CGFloat = 8, padding: EdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)) {
        self.tracks = tracks
        self.spacing = spacing
        self.axis = axis
        self.padding = padding
    }

    public func transform(preferences: inout [GridItemPreferences], in size: CGSize) {
        let computedTracksCount = self.axis == .vertical ?
            tracksCount(
                tracks: self.tracks,
                spacing: self.spacing,
                padding: self.padding.leading + self.padding.trailing,
                availableLength: size.width
            ) :
            tracksCount(
                tracks: self.tracks,
                spacing: self.spacing,
                padding: self.padding.top + self.padding.bottom,
                availableLength: size.height
            )

        let size = CGSize(
            width: itemLength(
                tracks: self.tracks,
                spacing: self.spacing,
                padding: self.padding.leading + self.padding.trailing,
                availableLength: size.width
            ),
            height: itemLength(
                tracks: self.tracks,
                spacing: self.spacing,
                padding: self.padding.top + self.padding.bottom,
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
    
    private func layoutPreferences(tracks: Int, spacing: CGFloat, axis: Axis, itemSize: CGSize, preferences: [GridItemPreferences]) -> [GridItemPreferences] {
        var tracksLengths = Array(repeating: CGFloat(0.0), count: tracks)
        var newPreferences: [GridItemPreferences] = []
        
        preferences.forEach { preference in
            if let minValue = tracksLengths.min(), let indexMin = tracksLengths.firstIndex(of: minValue) {
                let itemSizeWidth = axis == .vertical ? itemSize.width : preference.bounds.size.width
                let itemSizeHeight = axis == .vertical ? preference.bounds.size.height : itemSize.height
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

//    private func layoutPreferences(tracks: Int, spacing: CGFloat, axis: Axis.Set, size: CGSize, geometry: GeometryProxy, preferences: [AnyHashable: GridItemPreferences]) -> [AnyHashable: GridItemPreferences] {
//        var heights = Array(repeating: CGFloat(0), count: tracks)
//        var alignmentGuides: [AnyHashable: GridItemPreferences] = [:]
//        preferences.forEach { (key, value) in
//            if let minValue = heights.min(), let indexMin = heights.firstIndex(of: minValue) {
//                let size = CGSize(width: size.width, height: value.prefferedItemSize.height)
//                let preferenceSizeWidth = axis == .vertical ? size.width : size.height
//                let preferenceSizeHeight = axis == .vertical ? size.height : size.width
//                let width = preferenceSizeWidth * CGFloat(indexMin) + CGFloat(indexMin) * spacing
//                let height = heights[indexMin]
//                let offset = CGPoint(
//                    x: 0 - (axis == .vertical ? width : height),
//                    y: 0 - (axis == .vertical ? height : width)
//                )
//                heights[indexMin] += preferenceSizeHeight + spacing
//                alignmentGuides[key] = preferences[key]
//                alignmentGuides[key]?.origin = offset
//                alignmentGuides[key]?.itemWidth = preferenceSizeWidth
//                //alignmentGuides[key]?.itemHeight = preferenceSizeHeight
//            }
//        }
//
//        return alignmentGuides
//    }

}
