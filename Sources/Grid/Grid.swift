import SwiftUI

/// A view that arranges its children in a grid.
public struct Grid<Content>: View where Content: View {
    @Environment(\.gridStyle) private var style
    @State var itemsPreferences: [AnyHashable : GridItemPreferences] = [:]
    let items: [GridItem]
    
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
                ForEach(self.items) { item in
                    item.view
                        .frame(
                            width: self.style.autoWidth ? self.itemsPreferences[item.id]?.bounds.width : nil,
                            height: self.style.autoHeight ? self.itemsPreferences[item.id]?.bounds.height : nil
                        )
                        .alignmentGuide(.leading, computeValue: { _ in self.itemsPreferences[item.id]?.bounds.origin.x ?? 0 })
                        .alignmentGuide(.top, computeValue: { _ in self.itemsPreferences[item.id]?.bounds.origin.y ?? 0 })
                        .background(GridItemPreferencesModifier(id: item.id, bounds: self.itemsPreferences[item.id]?.bounds ?? .zero))
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
