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
                //.frame(minWidth: 300)
//            FixedColumnsLayoutView()
//                .tabItem {
//                    Text("Fixed Columns")
//                }
//                .tag(1)
//                .frame(minWidth: 300)
//            SingleColumnLayoutView()
//                .tabItem {
//                    Text("One Column")
//                }
//                .tag(2)
//                .frame(minWidth: 300)
//            PerformanceLayoutView()
//                .tabItem {
//                    Text("Performance")
//                }
//                .tag(3)
//                .frame(minWidth: 300)
//            BuilderLayoutView()
//                .tabItem {
//                    Text("Builder")
//                }
//                .tag(4)
//                .frame(minWidth: 300)
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
