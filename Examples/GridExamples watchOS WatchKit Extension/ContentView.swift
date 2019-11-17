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
        }
        .accentColor(.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
