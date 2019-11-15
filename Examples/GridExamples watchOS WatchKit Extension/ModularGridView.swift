import SwiftUI
import Grid

struct ModularGridView: View {
    @State var selection: Int = 0
    
    var body: some View {
        Grid(0...100) { number in
            Rectangle().foregroundColor(.random)
                .onTapGesture {
                    self.selection = number
                }
        }
        .gridStyle(
            ModularGridStyle(columns: .auto(.min(25)), rows: .auto(.min(25)), spacing: 1, padding: .init(top: 0, leading: 0, bottom: 0, trailing: 0))
        )
    }
}

struct ModularGridView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
