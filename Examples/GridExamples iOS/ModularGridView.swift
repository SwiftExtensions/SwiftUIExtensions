import SwiftUI
import Grid

struct ModularGridView: View {
    @State var items: [Item] = (0...100).map { Item(number: $0) }
    @State var showSettings: Bool = false
    @State var style = ModularGridStyle(columns: .min(100), rows: .min(100))
    
    var body: some View {
        NavigationView {
            Grid(items) { item in
                Card(title: "\(item.number)", color: item.color)
            }
            .gridStyle(
                self.style
            )
            .navigationBarTitle("Modular Grid", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: { self.showSettings = true }) {
                    Image(systemName: "gear")
                }
            )
        }

        .navigationViewStyle(
            StackNavigationViewStyle()
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
