import SwiftUI
import Grid

struct ModularGridView: View {
    @State var selection: Int = 0
    
    var body: some View {
        Grid(0...100) { number in
            Card(title: "\(number)")
                .focusable(true) { focus in
                    if focus {
                       self.selection = number
                    }
                }
        }
        .gridStyle(
            ModularGridStyle(columns: .auto(.min(200)), rows: .auto(.min(100)))
        )
    }
}

struct ModularGridView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
