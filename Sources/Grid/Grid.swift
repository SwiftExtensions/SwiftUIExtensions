import SwiftUI

/// A view that arranges its children in a grid.
public struct Grid<Content> : View where Content : View {
    @Environment(\.gridStyle) private var style
    @State private var alignmentGuides: [Int: CGPoint] = [:]
    private var configuration: GridStyleConfiguration
    
    public var body: some View {
        return self.style.makeBody(configuration: self.configuration.with(alignmentGuides: $alignmentGuides))
    }
    
}

extension Grid {
    public init<Data: RandomAccessCollection>(_ data: Data, axis: Axis = .vertical, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.configuration = GridStyleConfiguration(axis: axis, items: data.map({ AnyView(content($0)) }))
    }
    
    public init<Data: RandomAccessCollection, ID, Item: View>(_ axis: Axis = .vertical, @ViewBuilder content: () -> Content) where Content == ForEach<Data, ID, Item> {
        let views = content()
        self.configuration = GridStyleConfiguration(axis: axis, items: views.data.map { AnyView(views.content($0)) })
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
