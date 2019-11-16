import SwiftUI
import Grid

struct ModularGridView: View {
    @State var selection: Int = 0
    @State var items: [(Int, Color)] = (0...100).map { ($0, .random) }
    
    var body: some View {
        NavigationView {
            Grid(items, id: \.0) { item in
                Card(title: "\(item.0)", color: item.1)
                    .onTapGesture {
                        self.selection = item.0
                    }
            }
            .navigationBarTitle("Modular")
            .overlayPreferenceValue(GridItemBoundsKey.self) { preferences in
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(lineWidth: 4)
                        .foregroundColor(.white)
                        .frame(
                            width: geometry[preferences[self.selection]].size.width,
                            height: geometry[preferences[self.selection]].size.height
                        )
                        .position(
                            x: geometry[preferences[self.selection]].midX,
                            y: geometry[preferences[self.selection]].midY
                        )
                        .animation(.easeInOut)
                }
            }
        }
        .gridStyle(
            ModularGridStyle(columns: .auto(.min(100)), rows: .auto(.min(100)))
        )
        .navigationViewStyle(
            StackNavigationViewStyle()
        )



        
        
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
