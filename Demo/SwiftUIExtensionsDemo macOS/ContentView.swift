import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Layouts")) {
                    NavigationLink(destination: ModularGridView()) {
                        Text("Modular Grid")
                    }
                    
                    NavigationLink(destination: StaggeredGridView()) {
                        Text("Staggered Grid")
                    }
                }
                
                Section(header: Text("Data Visualization")) {
                    NavigationLink(destination: ChartsView()) {
                        Text("Charts")
                    }
                }
                
                Section(header: Text("Shapes")) {
                    NavigationLink(destination: RegularPolygonsView()) {
                        Text("Regular Polygons")
                    }
                    
                    NavigationLink(destination: LinesView()) {
                        Text("Lines")
                    }
                    
                    NavigationLink(destination: PatternsView()) {
                        Text("Patterns")
                    }
                }
            }
            .frame(minWidth: 200, maxWidth: 300)
            .listStyle(SidebarListStyle())
            
        }
        .navigationViewStyle(
            DoubleColumnNavigationViewStyle()
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

