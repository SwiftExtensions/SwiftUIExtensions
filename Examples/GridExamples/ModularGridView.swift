import SwiftUI
import Grid

struct ModularGridView: View {
    var body: some View {
        Grid(0...50) { number in
            Card(title: "\(number)")
                .frame(height: 160)
        }
        //.padding()
        .gridStyle(
            ModularGridStyle(columns: .auto(.min(100)))
        )
    }
}

struct FixedColumnsLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
