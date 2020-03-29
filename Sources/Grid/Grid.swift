import SwiftUI

/// A view that arranges its children in a grid.
public struct Grid<Content>: View where Content: View {
    @Environment(\.gridStyle) private var style
    @State var preferences: GridPreferences = GridPreferences(size: .zero, items: [])
    let items: [GridItem]
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(self.items) { item in
                    item.view
                        .frame(
                            width: self.style.autoWidth ? self.preferences[item.id]?.bounds.width : nil,
                            height: self.style.autoHeight ? self.preferences[item.id]?.bounds.height : nil
                        )
                        .alignmentGuide(.leading, computeValue: { _ in geometry.size.width - (self.preferences[item.id]?.bounds.origin.x ?? 0) })
                        .alignmentGuide(.top, computeValue: { _ in geometry.size.height - (self.preferences[item.id]?.bounds.origin.y ?? 0) })
                        .background(GridPreferencesModifier(id: item.id, bounds: self.preferences[item.id]?.bounds ?? .zero))
                        .anchorPreference(key: GridItemBoundsPreferencesKey.self, value: .bounds) { [geometry[$0]] }
                }
            }
            .transformPreference(GridPreferencesKey.self) {
                self.style.transform(preferences: &$0, in: geometry.size)
            }
        }
        .frame(
            minWidth: self.style.axis == .horizontal ? self.preferences.size.width : nil,
            minHeight: self.style.axis == .vertical ? self.preferences.size.height : nil,
            alignment: .topLeading
        )
        .onPreferenceChange(GridPreferencesKey.self) { preferences in
            self.preferences = preferences
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
