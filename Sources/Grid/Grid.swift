import SwiftUI

/// A view that arranges its children in a grid.
public struct Grid: View {
    @Environment(\.gridStyle) private var style
    
    let items: [AnyView]
    @State private var itemsPreferences: [GridItemPreferences]?
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .topLeading) {
                    ForEach(0..<self.items.count, id: \.self) { index in
                        self.items[index]
                            .background(GridItemPreferenceModifier(index: index))
                            .frame(
                                width: self.itemsPreferences?[index].itemWidth,
                                height: self.itemsPreferences?[index].itemHeight
                            )
                            .alignmentGuide(.leading, computeValue: { _ in self.itemsPreferences?[index].origin?.x ?? 0 })
                            .alignmentGuide(.top, computeValue: { _ in self.itemsPreferences?[index].origin?.y ?? 0 })
                    }
                }
                .padding(self.style.padding)
                .frame(
                    width: geometry.size.width
                )
            }
            .frame(width: geometry.size.width)
            .transformPreference(GridItemPreferencesKey.self) { preferences in
                preferences = self.style.itemPreferences(with: geometry, itemsCount: self.items.count, preferences: preferences)
            }
            .onPreferenceChange(GridItemPreferencesKey.self) { preferences in
                self.itemsPreferences = preferences
            }
        }
    }
}

struct GridItemPreferenceModifier: View {
    let index: Int
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: GridItemPreferencesKey.self, value:
                [GridItemPreferences(index: self.index, prefferedItemSize: geometry.size)]
            )
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
