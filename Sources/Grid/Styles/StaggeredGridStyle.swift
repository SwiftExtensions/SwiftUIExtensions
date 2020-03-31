import SwiftUI

/// Staggered `Grid` style.
public struct StaggeredGridStyle: GridStyle {
    public var tracks: Tracks
    public var axis: Axis
    public var spacing: CGFloat

    public init(_ axis: Axis = .vertical, tracks: Tracks, spacing: CGFloat = 8) {
        self.tracks = tracks
        self.spacing = spacing
        self.axis = axis
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        StaggeredGrid(items: configuration.items, tracks: tracks, axis: axis, spacing: spacing)
    }
}
