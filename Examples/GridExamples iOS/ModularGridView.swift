import SwiftUI
import Grid

struct ModularGridView: View {
    @State var items: [Item] = (0...100).map { Item(number: $0) }
    
    var body: some View {
        NavigationView {
            Grid(items) { item in
                Card(title: "\(item.number)", color: item.color)
            }
            .navigationBarTitle("Modular Grid", displayMode: .inline)
        }
        .gridStyle(
            ModularGridStyle(columns: .auto(.min(100)), rows: .auto(.min(100)))
        )
        .navigationViewStyle(
            StackNavigationViewStyle()
        )
    }
}

struct ModularGridView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
