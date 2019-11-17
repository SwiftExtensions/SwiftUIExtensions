import SwiftUI
import Grid

struct ModularGridView: View {
    @State var selection: Int = 0
    @State var items: [(Int, Color)] = (0...100).map { ($0, .random) }
    
    var body: some View {
        Grid(items, id: \.0) { item in
            Card(title: "\(item.0)", color: item.1)
                .onTapGesture {
                    self.selection = item.0
                }
        }
        .overlayPreferenceValue(GridItemBoundsPreferencesKey.self) { preferences in
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(lineWidth: 4)
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
            ModularGridStyle(columns: .auto(.min(200)), rows: .auto(.min(200)))
        )
    }
}

struct ModularGridView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
