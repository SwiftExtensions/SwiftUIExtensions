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
//            NavigationLink(destination: FixedColumnsLayoutView()) {
//                HStack {
//                    Image(systemName: "rectangle.split.3x3.fill")
//                        .foregroundColor(.accentColor)
//                    Text("Fixed Columns")
//                }
//            }
//            NavigationLink(destination: SingleColumnLayoutView()) {
//                HStack {
//                    Image(systemName: "rectangle.grid.1x2.fill")
//                        .foregroundColor(.accentColor)
//                    Text("One Column")
//                }
//            }
//            NavigationLink(destination: PerformanceLayoutView()) {
//                HStack {
//                    Image(systemName: "square.grid.4x3.fill")
//                        .foregroundColor(.accentColor)
//                    Text("Performance")
//                }
//            }
        }
        .accentColor(.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
