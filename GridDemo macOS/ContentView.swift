import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: ModularGridView()) {
                        Text("Modular Grid")
                    }
                    
                    NavigationLink(destination: StaggeredGridView()) {
                        Text("Staggered Grid")
                    }
                    
                    NavigationLink(destination: SectionedGridView()) {
                        Text("Sectioned Grid")
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
