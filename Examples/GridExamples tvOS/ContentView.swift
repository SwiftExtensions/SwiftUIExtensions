import SwiftUI
import Grid

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            AutoColumnsLayoutView()
                .font(.title)
                .tabItem {
                    HStack {
                        Image(systemName: "square.grid.3x2.fill")
                        Text("Auto Columns")
                    }
                }
                .frame(minWidth: 300)
                .tag(0)
                
            FixedColumnsLayoutView()
                .font(.title)
                .tabItem {
                    HStack {
                        Image(systemName: "rectangle.split.3x3.fill")
                        Text("Fixed Columns")
                    }
                }
                .frame(minWidth: 300)
                .tag(1)
            SingleColumnLayoutView()
                .font(.title)
                .tabItem {
                    HStack {
                        Image(systemName: "rectangle.grid.1x2.fill")
                        Text("One Column")
                    }
                }
                .frame(minWidth: 300)
                .tag(2)
            PerformanceLayoutView()
                .font(.title)
                .tabItem {
                    HStack {
                        Image(systemName: "square.grid.4x3.fill")
                        Text("Performance")
                    }
                }
                .frame(minWidth: 300)
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
