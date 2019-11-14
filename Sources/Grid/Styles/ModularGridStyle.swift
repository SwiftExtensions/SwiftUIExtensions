import SwiftUI

/// Staggered `Grid` style.
public struct ModularGridStyle: GridStyle {
    let columns: Tracks
    let rows: Tracks
    let spacing: CGFloat
    let padding: EdgeInsets
        
    public init(columns: Tracks, rows: Tracks, spacing: CGFloat = 8, padding: EdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)) {
        self.columns = columns
        self.rows = rows
        self.spacing = spacing
        self.padding = padding
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                self.grid(with: configuration, geometry: geometry)
            }
//            .onPreferenceChange(GridItemPreferences.Key.self) { preferences in
//                configuration.alignmentGuides?.wrappedValue = alignmentGuides(
//                    tracks: tracksCount(
//                        tracks: self.columns,
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
        }
    }
    
    private func grid(with configuration: Self.Configuration, geometry: GeometryProxy) -> some View {
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
        
        let guides = gridAlignmentGuides(
            tracks: computedTracksCount,
            spacing: self.spacing,
            axis: .vertical,
            size: size,
            views: configuration.items,
            geometry: geometry
        )
        
        return ZStack(alignment: .topLeading) {
            ForEach(0..<configuration.items.count, id: \.self) { index in
                configuration.items[index]
                    .frame(
                        width: size.width,
                        height: size.height
                    )
                    .anchorPreference(key: GridItemPreferences.Key.self, value: .bounds) {
                        [GridItemPreferences(index: index, anchor: $0)]
                    }
                    .alignmentGuide(.top, computeValue: { _ in guides[index].y } )
                    .alignmentGuide(.leading, computeValue: { _ in guides[index].x })

            }
        }
        .padding(self.padding)
        .frame(width: geometry.size.width)
    }
}
