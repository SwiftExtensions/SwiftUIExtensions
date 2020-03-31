import SwiftUI

/// Modular `Grid` style.
public struct ModularGridStyle: GridStyle {
    public var columns: Tracks
    public var rows: Tracks
    public var axis: Axis
    public var spacing: CGFloat
    public var autoWidth: Bool = true
    public var autoHeight: Bool = true
        
    public init(_ axis: Axis = .vertical, columns: Tracks, rows: Tracks, spacing: CGFloat = 8) {
        self.columns = columns
        self.rows = rows
        self.axis = axis
        self.spacing = spacing
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        ModularGrid(items: configuration.items, columns: columns, rows: rows, axis: axis, spacing: spacing)
    }
}
