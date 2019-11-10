import SwiftUI
import Grid

struct StaggeredGridView: View {
    @State var selection: Int = 0
    
    var body: some View {
        Grid(0...50) { number in
            #if os(tvOS)
            Card(title: "\(number)")
                .focusable(true) { focus in
                    if focus {
                       self.selection = number
                    }
                }
            #else
            Card(title: "\(number)")
                .frame(height: CGFloat(Int.random(in: 50...200)))
                .onTapGesture {
                    self.selection = number
                }
            #endif

        }

        //.padding()
        .gridStyle(
            StaggeredGridStyle()
        )
//        .gridStyle(
//            AutoColumnsGridStyle(minItemWidth: 240, itemHeight: 120)
//        )
        
//        .overlayPreferenceValue(GridItemPreferences.Key.self) { preferences in
//            if preferences.isEmpty {
//                EmptyView()
//            } else {
//                ZStack(alignment: .topLeading) {
//                    RoundedRectangle(cornerRadius: 16)
//                        .strokeBorder(lineWidth: 4)
//                        .foregroundColor(.white)
//                        .frame(
//                            width: preferences[self.selection].bounds.size.width,
//                            height: preferences[self.selection].bounds.size.height
//                        )
//                        .alignmentGuide(.top, computeValue: { _ in preferences[self.selection].bounds.minY })
//                        .alignmentGuide(.leading, computeValue: { _ in preferences[self.selection].bounds.minX })
//
//                        .animation(.spring())
//                }
//
//            }
//        }
    }
}

#if DEBUG
struct AutoColumnsGridView_Previews: PreviewProvider {
    static var previews: some View {
        StaggeredGridView()
    }
}
#endif
