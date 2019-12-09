import SwiftUI
import SwiftUIExtensions

struct ModularGridView: View {
    @State var selection: Int = 0
    @State var items: [Item] = (0...100).map { Item(number: $0) }
    @State var showSettings: Bool = false
    @State var style = ModularGridStyle(columns: .min(200), rows: .min(200))
    
    var body: some View {
        VStack(alignment: .trailing) {
            Button(action: { self.showSettings = true }) {
                Text("Settings")
            }
            .padding(.trailing, self.style.padding.trailing)
            
            Grid(items) { item in
                Card(title: "\(item.number)", color: item.color)
                    .onTapGesture {
                        self.selection = item.number
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
        }
        .sheet(isPresented: self.$showSettings) {
            ModularGridSettingsView(style: self.$style)
        }
        .gridStyle(
            self.style
        )
    }
}

struct ModularGridView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
