import SwiftUI
import Grid

struct ModularGridView: View {
    @State var selection: Int = 0
    @State var items: [Item] = (0...100).map { Item(number: $0) }
    
    var body: some View {
        Grid(items) { item in
            Card(title: "\(item.number)", color: item.color)
                .focusable(true) { focus in
                    if focus {
                       self.selection = item.number
                    }
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
            ModularGridStyle(columns: .min(300), rows: .min(100))
        )
        .navigationBarTitle("Modular Grid")
    }
}

struct ModularGridView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
