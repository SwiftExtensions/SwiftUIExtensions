import SwiftUI

/// The default `Grid` style.
public struct AutoColumnsGridStyle: GridStyle {
    public var padding = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    let minItemWidth: CGFloat
    let itemHeight: CGFloat
    let vSpacing: CGFloat
    let hSpacing: CGFloat
    
    public init(minItemWidth: CGFloat = 160, itemHeight: CGFloat = 160, spacing: CGFloat = 8) {
        self.minItemWidth = minItemWidth
        self.itemHeight = itemHeight
        self.vSpacing = spacing
        self.hSpacing = spacing
    }
    
    public init(minItemWidth: CGFloat = 160, itemHeight: CGFloat = 160, hSpacing: CGFloat = 8, vSpacing: CGFloat = 8) {
        self.minItemWidth = minItemWidth
        self.itemHeight = itemHeight
        self.hSpacing = hSpacing
        self.vSpacing = vSpacing
    }
    
    public func frameHeight(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGFloat {
        self.itemHeight
    }
    public func frameWidth(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGFloat {
        self.itemWidth(for: geometry, minItemWidth: self.minItemWidth, padding: self.padding, hSpacing: self.hSpacing)
    }
    
    public func position(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGPoint {
        let availableWidth = self.availableWidth(with: geometry, padding: padding, hSpacing: hSpacing)
        let columnCount = Int(availableWidth / minItemWidth)
        let row = index / max(1, columnCount)
        let itemIndexAtRow = index % max(1, columnCount)
        let itemWidth = self.itemWidth(for: geometry, minItemWidth: minItemWidth, padding: padding, hSpacing: hSpacing)
        let hSpacingForItem = CGFloat(itemIndexAtRow) * hSpacing
        let x = ((itemWidth / 2) + CGFloat(itemIndexAtRow) * itemWidth) + padding.leading + hSpacingForItem
        let y = ((itemHeight / 2) + CGFloat(row) * itemHeight) + padding.top + (CGFloat(row) * vSpacing)
        return CGPoint(x: x, y: y)
    }
    
    public func gridHeight(with geometry: GeometryProxy, itemsCount: Int) -> CGFloat {
        let availableWidth = self.availableWidth(with: geometry, padding: padding, hSpacing: hSpacing)
        let columnCount = Int(availableWidth / minItemWidth)
        let rowCount = Int((CGFloat(itemsCount) / max(1.0, CGFloat(columnCount))).rounded(.up))
        let verticalPadding = padding.top + padding.bottom
        return CGFloat(rowCount) * itemHeight + verticalPadding + (CGFloat(rowCount - 1) * vSpacing)
    }
        
    @inlinable func itemWidth(for geometry: GeometryProxy, minItemWidth: CGFloat, padding: EdgeInsets, hSpacing: CGFloat) -> CGFloat {
        let availableWidth = self.availableWidth(with: geometry, padding: padding, hSpacing: hSpacing)
        let columnCount = Int(availableWidth / minItemWidth)
        
        for columns in (0...columnCount).reversed() {
            let suggestedItemWidth = self.itemWidth(for: geometry, columns: columns, padding: padding, hSpacing: hSpacing)
            if (suggestedItemWidth * CGFloat(columns)) + (CGFloat(columns - 1) * hSpacing) <= availableWidth {
                return suggestedItemWidth
            }
        }
        return availableWidth
    }
}
