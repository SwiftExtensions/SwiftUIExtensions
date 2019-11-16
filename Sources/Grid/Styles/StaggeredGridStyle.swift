//import SwiftUI
//
///// Staggered `Grid` style.
//public struct StaggeredGridStyle: GridStyle {
//    let tracks: Tracks
//    let spacing: CGFloat
//    public let padding: EdgeInsets
//    
//    public init(tracks: Tracks, spacing: CGFloat = 8, padding: EdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)) {
//        self.tracks = tracks
//        self.spacing = spacing
//        self.padding = padding
//    }
//    
//    public func columnWidth(in geometry: GeometryProxy) -> CGFloat? {
//        itemLength(
//            tracks: self.tracks,
//            spacing: self.spacing,
//            padding: self.padding.leading + self.padding.trailing,
//            availableLength: geometry.size.width
//        )
//    }
//    
//    public func rowHeight(in geometry: GeometryProxy) -> CGFloat? {
//        nil
//    }
//    
//    public func transform(preferences: inout [AnyHashable: GridItemPreferences], in geometry: GeometryProxy) {
//        let computedTracksCount = tracksCount(
//            tracks: self.tracks,
//            spacing: self.spacing,
//            padding: self.padding.leading + self.padding.trailing,
//            availableLength: geometry.size.width
//        )
//        
//        let size = CGSize(
//            width: itemLength(
//                tracks: self.tracks,
//                spacing: self.spacing,
//                padding: self.padding.leading + self.padding.trailing,
//                availableLength: geometry.size.width
//            ),
//            height: itemLength(
//                tracks: self.tracks,
//                spacing: self.spacing,
//                padding: self.padding.top + self.padding.bottom,
//                availableLength: geometry.size.height
//            )
//        )
//        
//        preferences = staggeredGridAlignmentGuides(
//            tracks: computedTracksCount,
//            spacing: self.spacing,
//            axis: .vertical,
//            size: size,
//            geometry: geometry,
//            preferences: preferences
//        )
//    }
//    
//    private func staggeredGridAlignmentGuides(tracks: Int, spacing: CGFloat, axis: Axis.Set, size: CGSize, geometry: GeometryProxy, preferences: [AnyHashable: GridItemPreferences]) -> [AnyHashable: GridItemPreferences] {
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
//
//}
