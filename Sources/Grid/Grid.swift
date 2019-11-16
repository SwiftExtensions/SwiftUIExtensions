import SwiftUI

/// A view that arranges its children in a grid.
public struct Grid<Data, ID, Content>: View where Data : RandomAccessCollection, Content : View, ID : Hashable {
    @Environment(\.gridStyle) private var style
    
    let data: Data
    let id: KeyPath<Data.Element, ID>
    let content: (Data.Element) -> Content
    
    @State private var gridPreference: [AnyHashable: GridItemPreferences] = [:] {
        didSet { enableAnimations = !oldValue.isEmpty }
    }
    
    @State private var enableAnimations = false
    
    public var body: some View {
        GeometryReader { geometry in
            self.grid(with: geometry)
                .onPreferenceChange(GridItemPreferencesKey.self) { preferences in
                    DispatchQueue.global(qos: .utility).async {
                        let gridPreferences = preferences.reduce(into: [AnyHashable: GridItemPreferences](), { (result, preference) in
                            result[preference.id] = preference
                        })
                        DispatchQueue.main.async {
                            self.gridPreference = gridPreferences
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    private func grid(with geometry: GeometryProxy) -> some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                ForEach(data, id: self.id) { item in
                    self.content(item)
                        .frame(
                            width: self.gridPreference[item[keyPath: self.id]]?.bounds.width,
                            height: self.gridPreference[item[keyPath: self.id]]?.bounds.height
                        )
                        .alignmentGuide(.leading, computeValue: { _ in self.gridPreference[item[keyPath: self.id]]?.bounds.origin.x ?? 0 })
                        .alignmentGuide(.top, computeValue: { _ in self.gridPreference[item[keyPath: self.id]]?.bounds.origin.y ?? 0 })
                        .preference(key: GridItemPreferencesKey.self, value: [GridItemPreferences(id: AnyHashable(item[keyPath: self.id]), bounds: .zero)])
                        .anchorPreference(key: GridItemBoundsPreferencesKey.self, value: .bounds) { [geometry[$0]] }
                }
            }
            .transformPreference(GridItemPreferencesKey.self) {
                self.style.transform(preferences: &$0, in: geometry)
            }
            .padding(self.style.padding)
            .frame(width: geometry.size.width)
            .animation(self.enableAnimations ? self.style.layoutAnimation : nil)
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
