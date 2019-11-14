import SwiftUI
import Grid

struct ModularGridView: View {
    @State var selection: Int = 0
    
    var body: some View {
        NavigationView {
            Grid(0...100) { number in
                Card(title: "\(number)")
            }

//            .overlayPreferenceValue(GridItemPreferences.Key.self) { preferences in
//                Text("\(preferences.count)")
////                GeometryReader { geometry in
////                    RoundedRectangle(cornerRadius: 16)
////                        .strokeBorder(lineWidth: 4)
////                        .foregroundColor(.white)
////                        .frame(
////                            width: geometry[preferences[self.selection].anchor].size.width,
////                            height: geometry[preferences[self.selection].anchor].size.height
////                        )
////                        .offset(
////                            x: geometry[preferences[self.selection].anchor].minX,
////                            y: geometry[preferences[self.selection].anchor].minY
////                        )
////                        .animation(.spring())
////                }
//            }
            .navigationBarTitle("Modular")
//            .overlayPreferenceValue(GridItemPreferences.Key.self) { preferences in
//                if preferences.isEmpty {
//                    EmptyView()
//                } else {
//                    GeometryReader { geometry in
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 16)
//                                .strokeBorder(lineWidth: 4)
//                                .foregroundColor(.white)
//                                .frame(
//                                    width: geometry[preferences[self.selection].anchor].size.width,
//                                    height: geometry[preferences[self.selection].anchor].size.height
//                                )
//                                .alignmentGuide(.top, computeValue: { _ in geometry[preferences[self.selection].anchor].minY })
//                                .alignmentGuide(.leading, computeValue: { _ in geometry[preferences[self.selection].anchor].minX })
//
//                                .animation(.spring())
//                        }
//                    }
//                }
//            }
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
