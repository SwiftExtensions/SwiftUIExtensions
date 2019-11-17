import SwiftUI
import Grid

struct ModularGridView: View {
    @State var selection: Int = 0
    @State var items: [(Int, Color)] = (0...100).map { ($0, .random) }
    
    var body: some View {
       Grid(items, id: \.0) { item in
            Rectangle()
                .foregroundColor(item.1)
                .cornerRadius(4)
                .onTapGesture {
                    self.selection = item.0
                }
        }
        .overlayPreferenceValue(GridItemBoundsPreferencesKey.self) { preferences in
            RoundedRectangle(cornerRadius: 4)
                .strokeBorder(lineWidth: 2)
                .foregroundColor(.white)
                .frame(
                    width: preferences[self.selection].width,
                    height: preferences[self.selection].height
                )
                .position(
                    x: preferences[self.selection].midX,
                    y: preferences[self.selection].midY
                )
                .animation(.linear)
        }
        .gridStyle(
            ModularGridStyle(columns: .auto(.min(32)), rows: .auto(.min(32)), spacing: 4)
        )
    }
}

struct ModularGridView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
