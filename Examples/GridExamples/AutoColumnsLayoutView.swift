import SwiftUI
import Grid

struct AutoColumnsLayoutView: View {
    @State var selection: Int = 0
    
    var body: some View {
        Grid(0..<100) { number in
            #if os(tvOS)
            Card(title: "\(number)")
                .focusable(true) { focus in
                    if focus {
                       self.selection = number
                    }
                }
            #else
            Card(title: "\(number)")
                .onTapGesture {
                    self.selection = number
                }
            #endif

        }
        .padding()
        .gridStyle(AutoColumnsGridStyle(minItemWidth: 240, itemHeight: 120))
        
        .overlayPreferenceValue(GridItemPreferences.Key.self) { preferences in
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(lineWidth: 4)
                    .foregroundColor(.white)
                    .frame(
                        width: geometry[preferences[self.selection].bounds].size.width,
                        height: geometry[preferences[self.selection].bounds].size.height
                    )
                    .offset(
                        x: geometry[preferences[self.selection].bounds].minX,
                        y: geometry[preferences[self.selection].bounds].minY
                    )
                    .animation(.spring())
            }
        }
    }
}

#if DEBUG
struct AutoColumnsGridView_Previews: PreviewProvider {
    static var previews: some View {
        AutoColumnsLayoutView()
    }
}
#endif
