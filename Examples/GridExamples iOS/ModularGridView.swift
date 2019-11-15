import SwiftUI
import Grid

struct ModularGridView: View {
    @State var selection: Int = 0
    
    var body: some View {
        NavigationView {
            Grid(0...100) { number in
                Card(title: "\(number)")
                    .onTapGesture {
                        self.selection = number
                    }
            }

            
            .navigationBarTitle("Modular")
        }
        .gridStyle(
            ModularGridStyle(columns: .auto(.min(100)), rows: 6)
        )
        .navigationViewStyle(
            StackNavigationViewStyle()
        )

        
        
//        .overlayPreferenceValue(GridItemPreferencesKey.self) { preferences in
//            GeometryReader { geometry in
//                RoundedRectangle(cornerRadius: 16)
//                    .strokeBorder(lineWidth: 4)
//                    .foregroundColor(.white)
//                    .frame(
//                        width: geometry[preferences[self.selection].boundsAnchor].size.width,
//                        height: geometry[preferences[self.selection].boundsAnchor].size.height
//                    )
//                    .position(
//                        x: geometry[preferences[self.selection].boundsAnchor].minX,
//                        y: geometry[preferences[self.selection].boundsAnchor].minY
//                    )
//            }
//        }

        
        
//        .overlayPreferenceValue(GridItemPreferencesKey.self) { preferences in
//            GeometryReader { geometry in
//                ZStack(alignment: .topLeading) {
//                    RoundedRectangle(cornerRadius: 16)
//                        .strokeBorder(lineWidth: 4)
//                        .foregroundColor(.white)
//                        .frame(
//                            width: preferences[self.selection].bounds.size.width,
//                            height: preferences[self.selection].bounds.size.height
//                        )
//                        .alignmentGuide(.top, computeValue: { _ in preferences[self.selection].origin?.y ?? 0 })
//                        .alignmentGuide(.leading, computeValue: { _ in preferences[self.selection].origin?.x ?? 0 })
//                }
//                .frame(width: geometry.size.width, height: geometry.size.height)
//            }
//
//        }
    }
}

struct ModularGridView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridView()
    }
}
