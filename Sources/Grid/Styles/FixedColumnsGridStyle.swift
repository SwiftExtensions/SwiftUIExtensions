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
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack {
                    ForEach(0..<configuration.items.count, id: \.self) { index in
                        configuration.items[index]
                            .frame(
                                width: self.frameWidth(at: index, with: geometry, itemsCount: configuration.items.count),
                                height: self.frameHeight(at: index, with: geometry, itemsCount: configuration.items.count)
                            )

                            .position(self.position(at: index, with: geometry, itemsCount: configuration.items.count))
                            .anchorPreference(key: GridItemPreferences.Key.self, value: .rect(self.itemRect(at: index, with: geometry, itemsCount: configuration.items.count))) {
                                [GridItemPreferences(index: index, bounds: $0)]
                            }
                    }
                }
                .frame(
                    width: geometry.size.width,
                    height: self.gridHeight(with: geometry, itemsCount: configuration.items.count)
                )
            }
        }
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
    
    
    /// Translated from center origin to leading.
    @inlinable func itemRect(at index: Int, with geometry: GeometryProxy, itemsCount: Int) -> CGRect {
        CGRect(
            x: self.position(at: index, with: geometry, itemsCount: itemsCount).x - geometry.size.width / 2,
            y: self.position(at: index, with: geometry, itemsCount: itemsCount).y - geometry.size.height / 2,
            width: self.frameWidth(at: index, with: geometry, itemsCount: itemsCount),
            height: self.frameHeight(at: index, with: geometry, itemsCount: itemsCount)
        )
    }
    
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
