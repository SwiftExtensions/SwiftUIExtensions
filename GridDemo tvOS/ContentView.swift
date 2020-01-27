import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: ModularGridView()) {
                        HStack {
                            Image(systemName: "square.grid.3x2.fill")
                                .foregroundColor(.accentColor)
                            Text("Modular")
                        }
                        .focusable(true)
                    }
                    
                    
                    NavigationLink(destination: StaggeredGridView()) {
                        HStack {
                            Image(systemName: "rectangle.3.offgrid.fill")
                                .foregroundColor(.accentColor)
                            Text("Staggered")
                        }
                        .focusable(true)
                        
                    }
                    
                }
            }
            .navigationBarTitle("Grid")
            .listStyle(
                GroupedListStyle()
            )
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

