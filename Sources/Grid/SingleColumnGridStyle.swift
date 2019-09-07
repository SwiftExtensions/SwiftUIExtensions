import SwiftUI

/// Single column `Grid` style.
public struct SingleColumnGridStyle: GridStyle {
    public var padding = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    private let itemHeight: CGFloat
    private let spacing: CGFloat
    
    public init(itemHeight: CGFloat, spacing: CGFloat = 8) {
        self.itemHeight = itemHeight
        self.spacing = spacing
    }
    
    public func frameHeight(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGFloat {
        itemHeight
    }
    public func frameWidth(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGFloat {
        geometry.size.width - (padding.leading + padding.trailing)
    }
    
    public func position(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGPoint {
        let x = padding.leading + ((geometry.size.width - (padding.leading + padding.trailing)) / 2)
        let y = ((itemHeight / 2) + CGFloat(index) * itemHeight) + padding.top + (CGFloat(index) * spacing)
        return CGPoint(x: x, y: y)
    }
    
    public func gridHeight(with geometry: GeometryProxy, itemsCount: Int) -> CGFloat {
        let verticalPadding = padding.top + padding.bottom
        return CGFloat(itemsCount) * itemHeight + verticalPadding + (CGFloat(itemsCount - 1) * spacing)
    }
}
