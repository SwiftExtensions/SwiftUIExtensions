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
