import SwiftUI
import Grid

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ModularGridView()
                .tabItem {
                    Text("Modular")
                }
                .tag(0)
            StaggeredGridView()
                .tabItem {
                    Text("Staggered")
                }
                .tag(0)
        }
        .frame(minWidth: 600, maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
