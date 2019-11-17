import SwiftUI
import Grid

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection) {
            ModularGridView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.grid.3x2.fill")
                        Text("Modular")
                    }
                }
                .tag(0)
            StaggeredGridView()
                .tabItem {
                    VStack {
                        Image(systemName: "rectangle.3.offgrid.fill")
                        Text("Staggered")
                    }
                }
                .tag(1)
        }
        .accentColor(.purple)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
