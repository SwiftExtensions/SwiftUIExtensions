import SwiftUI

struct StaggeredGrid: View {
    @State var preferences: GridPreferences = GridPreferences(size: .zero, items: [])
    let items: [GridItem]
    public var tracks: Tracks
    public var axis: Axis
    public var spacing: CGFloat
    
    public var autoWidth: Bool {
        axis == .vertical
    }
    public var autoHeight: Bool {
        axis == .horizontal
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(self.items) { item in
                    item.view
                        .frame(
                            width: self.autoWidth ? self.preferences[item.id]?.bounds.width : nil,
                            height: self.autoHeight ? self.preferences[item.id]?.bounds.height : nil
                        )
                        .alignmentGuide(.leading, computeValue: { _ in geometry.size.width - (self.preferences[item.id]?.bounds.origin.x ?? 0) })
                        .alignmentGuide(.top, computeValue: { _ in geometry.size.height - (self.preferences[item.id]?.bounds.origin.y ?? 0) })
                        .background(GridPreferencesModifier(id: item.id, bounds: self.preferences[item.id]?.bounds ?? .zero))
                        .anchorPreference(key: GridItemBoundsPreferencesKey.self, value: .bounds) { [geometry[$0]] }
                }
            }
            .transformPreference(GridPreferencesKey.self) {
                StaggeredGridLayout(axis: self.axis, tracks: self.tracks, spacing: self.spacing)
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
