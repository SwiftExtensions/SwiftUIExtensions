import SwiftUI

/// A specification for the appearance of a `Grid`.
public protocol GridStyle {
    var padding: EdgeInsets { get set }
    
    func frameHeight(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGFloat
    func frameWidth(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGFloat
    func position(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGPoint
    func gridHeight(with geometry: GeometryProxy, itemsCount: Int) -> CGFloat
    
    func itemRect(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGRect
}

public extension GridStyle {
    /// Translated from center origin to leading.
    @inlinable func itemRect(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGRect {
        CGRect(
            x: self.position(at: index, with: geometry, itemsCount: itemsCount).x - geometry.size.width / 2,
            y: self.position(at: index, with: geometry, itemsCount: itemsCount).y - geometry.size.height / 2,
            width: self.frameWidth(at: index, with: geometry, itemsCount: itemsCount),
            height: self.frameHeight(at: index, with: geometry, itemsCount: itemsCount)
        )
    }
}


extension GridStyle {
    @inlinable func availableWidth(with geometry: GeometryProxy, padding: EdgeInsets, hSpacing: CGFloat) -> CGFloat {
        let horizontalPadding = padding.leading + padding.trailing
        return geometry.size.width - horizontalPadding
    }
    
    @inlinable func itemWidth(for geometry: GeometryProxy, columns: Int, padding: EdgeInsets, hSpacing: CGFloat) -> CGFloat {
        let availableWidth = self.availableWidth(with: geometry, padding: padding, hSpacing: hSpacing)
        let usableWidth = availableWidth - (CGFloat(columns - 1) * hSpacing)
        return usableWidth / CGFloat(columns)
    }
}
