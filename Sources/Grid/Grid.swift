import SwiftUI

/// A view that arranges its children in a grid.
public struct Grid<Content> : View where Content : View {
    @Environment(\.gridStyle) var style
    
    let items: [AnyView]
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack {
                    ForEach(0..<self.items.count, id: \.self) { index in
                        self.items[index]
                            .frame(
                                width: self.style.frameWidth(at: index, with: geometry, itemsCount: self.items.count),
                                height: self.style.frameHeight(at: index, with: geometry, itemsCount: self.items.count)
                            )

                            .position(self.style.position(at: index, with: geometry, itemsCount: self.items.count))
                            .anchorPreference(key: GridItemPreferences.Key.self, value: .rect(self.style.itemRect(at: index, with: geometry, itemsCount: self.items.count))) {
                                [GridItemPreferences(index: index, bounds: $0)]
                            }
                    }
                }
                .frame(
                    width: geometry.size.width,
                    height: self.style.gridHeight(with: geometry, itemsCount: self.items.count)
                )
            }
        }
    }
}

#if DEBUG
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid(0...100) {
            Text("\($0)")
        }
    }
}
#endif
