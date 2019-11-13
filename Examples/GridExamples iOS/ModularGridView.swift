import SwiftUI
import Grid

struct ModularGridView: View {
    var body: some View {
        NavigationView {
            Grid(0...100) { number in
                Card(title: "\(number)")
            }
            .navigationBarTitle("Modular", displayMode: .inline)
        }
        .navigationViewStyle(
            StackNavigationViewStyle()
        )
        .gridStyle(
            ModularGridStyle(columns: .auto(.min(100)))
        )
    }
}

struct ModularGridView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
