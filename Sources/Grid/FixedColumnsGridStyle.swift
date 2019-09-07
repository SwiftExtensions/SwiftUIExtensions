import SwiftUI

/// Fixed columns `Grid` style.
public struct FixedColumnsGridStyle: GridStyle {
    public var padding = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    private let columns: Int
    private let itemHeight: CGFloat
    private let hSpacing: CGFloat
    private let vSpacing: CGFloat
    
    public init(columns: Int, itemHeight: CGFloat, spacing: CGFloat = 8) {
        self.columns = columns
        self.itemHeight = itemHeight
        self.vSpacing = spacing
        self.hSpacing = spacing
    }
    
    public init(columns: Int, itemHeight: CGFloat, hSpacing: CGFloat = 8, vSpacing: CGFloat = 8) {
        self.columns = columns
        self.itemHeight = itemHeight
        self.hSpacing = hSpacing
        self.vSpacing = vSpacing
    }
    
    public func frameHeight(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGFloat {
        self.itemHeight
    }
    public func frameWidth(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGFloat {
        self.itemWidth(for: geometry, columns: self.columns, padding: self.padding, hSpacing: self.hSpacing)
    }
    
    public func position(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGPoint {
        let row = index / max(1, columns)
        let itemIndexAtRow = index % max(1, columns)
        let itemWidth = self.itemWidth(for: geometry, columns: columns, padding: padding, hSpacing: hSpacing)
        let hSpacingForItem = CGFloat(itemIndexAtRow) * hSpacing
        let x = ((itemWidth / 2) + CGFloat(itemIndexAtRow) * itemWidth) + padding.leading + hSpacingForItem
        let y = ((itemHeight / 2) + CGFloat(row) * itemHeight) + padding.top + (CGFloat(row) * vSpacing)
        return CGPoint(x: x, y: y)
    }
    
    public func gridHeight(with geometry: GeometryProxy, itemsCount: Int) -> CGFloat {
        let rowCount = Int((CGFloat(itemsCount) / max(1.0, CGFloat(columns))).rounded(.up))
        let verticalPadding = padding.top + padding.bottom
        return CGFloat(rowCount) * itemHeight + verticalPadding + (CGFloat(rowCount - 1) * vSpacing)
    }
}
