import SwiftUI
import Grid

struct ContentView: View {
    var body: some View {
        List {
            NavigationLink(destination: ModularGridView()) {
                HStack {
                    Image(systemName: "square.grid.3x2.fill")
                        .foregroundColor(.accentColor)
                    Text("Modular")
                }
                
            }
            
            NavigationLink(destination: StaggeredGridView()) {
                HStack {
                    Image(systemName: "rectangle.3.offgrid.fill")
                        .foregroundColor(.accentColor)
                    Text("Staggered")
                }
                
            }
        }
        .accentColor(.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
