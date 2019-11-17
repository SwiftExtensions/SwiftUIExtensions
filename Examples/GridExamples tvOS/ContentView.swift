import SwiftUI
import Grid

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            ModularGridView()
                .font(.title)
                .tabItem {
                    HStack {
                        Image(systemName: "square.grid.3x2.fill")
                        Text("Modular")
                    }
                }
                .tag(0)
            StaggeredGridView()
                .font(.title)
                .tabItem {
                    HStack {
                        Image(systemName: "rectangle.3.offgrid.fill")
                        Text("Staggered")
                    }
                }
                .tag(0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
