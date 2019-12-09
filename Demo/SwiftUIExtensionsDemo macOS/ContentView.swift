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
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 200, maxWidth: 300)
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

