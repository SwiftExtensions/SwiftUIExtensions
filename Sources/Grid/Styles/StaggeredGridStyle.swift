import SwiftUI

/// Staggered `Grid` style.
public struct StaggeredGridStyle: GridStyle {
    let tracks: Tracks
    let spacing: CGFloat
    public let padding: EdgeInsets
    
    public init(tracks: Tracks, spacing: CGFloat = 8, padding: EdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)) {
        self.tracks = tracks
        self.spacing = spacing
        self.padding = padding
    }
    
    public func itemPreferences(with geometry: GeometryProxy, itemsCount: Int, preferences: [GridItemPreferences]) -> [GridItemPreferences] {
        let computedTracksCount = tracksCount(
            tracks: self.tracks,
            spacing: self.spacing,
            padding: self.padding.leading + self.padding.trailing,
            availableLength: geometry.size.width
        )
        
        let size = CGSize(
            width: itemLength(
                tracks: self.tracks,
                spacing: self.spacing,
                padding: self.padding.leading + self.padding.trailing,
                availableLength: geometry.size.width
            ),
            height: itemLength(
                tracks: self.tracks,
                spacing: self.spacing,
                padding: self.padding.top + self.padding.bottom,
                availableLength: geometry.size.height
            )
        )
        
        return staggeredGridAlignmentGuides(
            tracks: computedTracksCount,
            spacing: self.spacing,
            axis: .vertical,
            size: size,
            viewsCount: itemsCount,
            geometry: geometry,
            preferences: preferences
        )
    }
    
    
    @inlinable func staggeredGridAlignmentGuides(tracks: Int, spacing: CGFloat, axis: Axis.Set, size: CGSize, viewsCount: Int, geometry: GeometryProxy, preferences: [GridItemPreferences]) -> [GridItemPreferences] {
        guard !preferences.isEmpty else { return [] }
        var heights = Array(repeating: CGFloat(0), count: tracks)
        var alignmentGuides: [GridItemPreferences] = []

        (0..<viewsCount).forEach { index in
            if let minValue = heights.min(), let indexMin = heights.firstIndex(of: minValue) {
                let anchorSize = preferences[index].prefferedItemSize
                let preferenceSizeWidth = axis == .vertical ? anchorSize.width : anchorSize.height
                let preferenceSizeHeight = axis == .vertical ? anchorSize.height : anchorSize.width
                let width = preferenceSizeWidth * CGFloat(indexMin) + CGFloat(indexMin) * spacing
                let height = heights[indexMin]
                let offset = CGPoint(
                    x: (0 - (axis == .vertical ? width : height)).rounded(),
                    y: (0 - (axis == .vertical ? height : width)).rounded()
                )
                heights[indexMin] += preferenceSizeHeight + spacing
                alignmentGuides.append(GridItemPreferences(index: index, prefferedItemSize: preferences[index].prefferedItemSize, origin: offset, itemWidth: size.width, itemHeight: nil))
            }
        }

        return alignmentGuides
    }
    
//    public func makeBody(configuration: Self.Configuration) -> some View {
//        Text("123")
//        GeometryReader { geometry in
//            ScrollView {
//                ZStack(alignment: .topLeading) {
//                    ForEach(0..<configuration.items.count, id: \.self) { index in
//                        configuration.items[index]
//                            .frame(
//                                width: itemLength(
//                                    tracks: self.tracks,
//                                    spacing: self.spacing,
//                                    padding: self.padding.leading + self.padding.trailing,
//                                    availableLength: geometry.size.width
//                                )
//                            )
//                            .alignmentGuide(.top, computeValue: { _ in configuration.alignmentGuides?.wrappedValue[index]?.y ?? 0 } )
//                            .alignmentGuide(.leading, computeValue: { _ in configuration.alignmentGuides?.wrappedValue[index]?.x ?? 0 })
//                            .anchorPreference(key: GridItemPreferences.Key.self, value: .bounds) {
//                                [GridItemPreferences(index: index, anchor: $0)]
//                            }
//                    }
//                }
//                .frame(width: geometry.size.width)
//                .padding(self.padding)
//            }
//            .frame(width: geometry.size.width, height: geometry.size.height)
//            .onPreferenceChange(GridItemPreferences.Key.self) { preferences in
//                configuration.alignmentGuides?.wrappedValue = alignmentGuides(
//                    tracks: tracksCount(
//                        tracks: self.tracks,
//                        spacing: self.spacing,
//                        padding: self.padding.leading + self.padding.trailing,
//                        availableLength: geometry.size.width
//                    ),
//                    spacing: self.spacing,
//                    axis: .vertical,
//                    preferences: preferences,
//                    geometry: geometry
//                )
//            }
//        }
//    }
}
