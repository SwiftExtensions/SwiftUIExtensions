import SwiftUI
import SwiftUIExtensions

struct ModularGridView: View {
    @State var items: [Item] = (0...100).map { Item(number: $0) }
    @State var showSettings: Bool = false
    @State var style = ModularGridStyle(columns: .min(100), rows: .min(100))
    
    var body: some View {
        Grid(items) { item in
            Card(title: "\(item.number)", color: item.color)
        }
        .gridStyle(
            self.style
        )
        .navigationBarTitle("Modular Grid", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: { self.showSettings = true }) {
                Image(systemName: "gear")
            }
        )
        .sheet(isPresented: $showSettings) {
            ModularGridSettingsView(style: self.$style).accentColor(.purple)
        }
    }
}

struct ModularGridView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
