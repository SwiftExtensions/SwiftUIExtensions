import SwiftUI

/// A view that arranges its children in a grid.
public struct Grid<Content>: View where Content: View {
    @Environment(\.gridStyle) private var style
    let items: [AnyView]
    @State private var itemsPreferences: [AnyHashable : GridItemPreferences] = [:]
    
    public var body: some View {
        GeometryReader { geometry in
            self.grid(with: geometry)
                .onPreferenceChange(GridItemPreferencesKey.self) { preferences in
                    DispatchQueue.global(qos: .utility).async {
                        let itemsPreferences = preferences.reduce(into: [AnyHashable: GridItemPreferences](), { (result, preference) in
                            result[preference.id] = preference
                        })
                        DispatchQueue.main.async {
                            self.itemsPreferences = itemsPreferences
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    private func grid(with geometry: GeometryProxy) -> some View {
        ScrollView(self.style.axis == .vertical ? .vertical : .horizontal) {
            ZStack(alignment: .topLeading) {
                ForEach(0..<self.items.count, id: \.self) { index in
                    self.items[index]
                        .frame(
                            width: self.style.autoWidth ? self.itemsPreferences[AnyHashable(index)]?.bounds.width : nil,
                            height: self.style.autoHeight ? self.itemsPreferences[AnyHashable(index)]?.bounds.height : nil
                        )
                        .alignmentGuide(.leading, computeValue: { _ in self.itemsPreferences[AnyHashable(index)]?.bounds.origin.x ?? 0 })
                        .alignmentGuide(.top, computeValue: { _ in self.itemsPreferences[AnyHashable(index)]?.bounds.origin.y ?? 0 })
                        .background(GridItemPreferencesModifier(id: AnyHashable(index), bounds: self.itemsPreferences[AnyHashable(index)]?.bounds ?? .zero))
                        .anchorPreference(key: GridItemBoundsPreferencesKey.self, value: .bounds) { [geometry[$0]] }
                }
            }
            .transformPreference(GridItemPreferencesKey.self) {
                self.style.transform(preferences: &$0, in: geometry.size)
            }
            .padding(self.style.padding)
            .frame(
                width: self.style.axis == .vertical ? geometry.size.width : nil,
                height: self.style.axis == .vertical ? nil : geometry.size.height,
                alignment: .topLeading
            )
        }
    }
}

#if DEBUG
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid(0...100, id: \.self) {
            Text("\($0)")
        }
    }
}
#endif
