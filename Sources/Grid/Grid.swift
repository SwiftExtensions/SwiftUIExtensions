import SwiftUI

/// A view that arranges its children in a grid.
public struct Grid<Data, ID, Content>: View where Data : RandomAccessCollection, Content : View, ID : Hashable {
    @Environment(\.gridStyle) private var style
    let data: Data
    let dataId: KeyPath<Data.Element, ID>
    let content: (Data.Element) -> Content
    @State private var gridPreference: [AnyHashable: GridItemPreferences] = [:]
    
    public var body: some View {
        GeometryReader { geometry in
            self.grid(with: geometry)
        }
        .onPreferenceChange(GridItemPreferencesKey.self) { preferences in
            self.gridPreference = preferences.reduce(into: [AnyHashable: GridItemPreferences](), { (result, preference) in
                result[preference.id] = preference
            })
        }
    }
    
    private func grid(with geometry: GeometryProxy) -> some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                ForEach(data, id: self.dataId) { element in
                    self.content(element)
                        .frame(
                            width: self.gridPreference[element[keyPath: self.dataId]]?.itemWidth,
                            height: self.gridPreference[element[keyPath: self.dataId]]?.itemHeight
                        )
                        
                        .background(GridItemPreferenceReader(id: element[keyPath: self.dataId]))
                        .alignmentGuide(.leading, computeValue: { _ in self.gridPreference[element[keyPath: self.dataId]]?.origin?.x ?? 0 })
                        .alignmentGuide(.top, computeValue: { _ in self.gridPreference[element[keyPath: self.dataId]]?.origin?.y ?? 0 })
                        .anchorPreference(key: GridItemBoundsKey.self, value: .bounds) { [$0] }
                }
                
            }
            .padding(self.style.padding)
            .frame(width: geometry.size.width)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .transformPreference(GridItemPreferencesKey.self) {
                self.style.transform(preferences: &$0, in: geometry)
            }
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
