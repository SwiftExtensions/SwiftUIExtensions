import SwiftUI
import Grid

struct ModularGridView: View {
    @State var selection: Int = 0
    
    var body: some View {
        Grid(0...100, id: \.self) { number in
            Card(title: "\(number)")
                .onTapGesture {
                    self.selection = number
                }
        }
        .gridStyle(
            ModularGridStyle(columns: .auto(.min(100)), rows: .auto(.min(100)))
        )

        
        
//        .overlayPreferenceValue(GridItemPreferencesKey.self) { preferences in
//            GeometryReader { geometry in
//                RoundedRectangle(cornerRadius: 16)
//                    .strokeBorder(lineWidth: 4)
//                    .foregroundColor(.white)
//                    .frame(
//                        width: preferences[self.selection].bounds.size.width,
//                        height: preferences[self.selection].bounds.size.height
//                    )
//                    .offset(
//                        x: preferences[self.selection].bounds.minX,
//                        y: preferences[self.selection].bounds.minY
//                    )
//            }
//        }
    }
}

struct ModularGridView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
