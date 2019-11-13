import SwiftUI

/// Staggered `Grid` style.
public struct StaggeredGridStyle: GridStyle {
    let tracks: Tracks
    let spacing: CGFloat
    let padding: EdgeInsets
    
    public init(tracks: Tracks, spacing: CGFloat = 8, padding: EdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)) {
        self.tracks = tracks
        self.spacing = spacing
        self.padding = padding
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .topLeading) {
                    ForEach(0..<configuration.items.count, id: \.self) { index in
                        configuration.items[index]
                            .frame(
                                width: itemLength(
                                    tracks: self.tracks,
                                    spacing: self.spacing,
                                    padding: self.padding.leading + self.padding.trailing,
                                    availableLength: geometry.size.width
                                )
                            )
                            .alignmentGuide(.top, computeValue: { _ in configuration.alignmentGuides?.wrappedValue[index]?.y ?? 0 } )
                            .alignmentGuide(.leading, computeValue: { _ in configuration.alignmentGuides?.wrappedValue[index]?.x ?? 0 })
                            .anchorPreference(key: GridItemPreferences.Key.self, value: .bounds) {
                                [GridItemPreferences(index: index, bounds: geometry[$0])]
                            }
                    }
                }
                .frame(width: geometry.size.width)
                .padding(self.padding)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onPreferenceChange(GridItemPreferences.Key.self) { preferences in
                configuration.alignmentGuides?.wrappedValue = alignmentGuides(
                    tracks: tracksCount(
                        tracks: self.tracks,
                        spacing: self.spacing,
                        padding: self.padding.leading + self.padding.trailing,
                        availableLength: geometry.size.width
                    ),
                    spacing: self.spacing,
                    axis: .vertical,
                    preferences: preferences
                )
            }
        }
    }
}
