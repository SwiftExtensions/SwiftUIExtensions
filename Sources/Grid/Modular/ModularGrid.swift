import SwiftUI

struct ModularGrid: View {
    @State var preferences = GridPreferences()
    let items: [GridItem]
    var columns: Tracks
    var rows: Tracks
    var axis: Axis
    var spacing: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(self.items) { item in
                    item.view
                        .frame(
                            width: self.preferences[item.id]?.bounds.width,
                            height: self.preferences[item.id]?.bounds.height
                        )
                        .alignmentGuide(.leading, computeValue: { _ in geometry.size.width - (self.preferences[item.id]?.bounds.origin.x ?? 0) })
                        .alignmentGuide(.top, computeValue: { _ in geometry.size.height - (self.preferences[item.id]?.bounds.origin.y ?? 0) })
                        .background(GridPreferencesModifier(id: item.id, bounds: self.preferences[item.id]?.bounds ?? .zero))
                        .anchorPreference(key: GridItemBoundsPreferencesKey.self, value: .bounds) { [geometry[$0]] }
                }
            }
            .transformPreference(GridPreferencesKey.self) {
                ModularGridLayout(axis: self.axis, columns: self.columns, rows: self.rows, spacing: self.spacing)
                    .transform(preferences: &$0, in: geometry.size)
            }
        }
        .frame(
            minWidth: self.axis == .horizontal ? self.preferences.size.width : nil,
            minHeight: self.axis == .vertical ? self.preferences.size.height : nil,
            alignment: .topLeading
        )
        .onPreferenceChange(GridPreferencesKey.self) { preferences in
            self.preferences = preferences
        }
    }
}
