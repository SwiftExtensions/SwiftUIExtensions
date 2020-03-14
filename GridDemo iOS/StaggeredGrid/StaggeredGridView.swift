import SwiftUI
import Grid

struct StaggeredGridView: View {
    @State var showSettings: Bool = false
    @State var style = StaggeredGridStyle(.vertical, tracks: .min(100), spacing: 1)
    @State var items: [Int] = (1...69).map { $0 }
    
    var body: some View {
        ScrollView(style.axes) {
            Grid(self.items, id: \.self) { index in
                NavigationLink(destination: ImageDetailView(imageName: "\(index)")) {
                    Image("\(index)")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                }
            }
            .animation(.easeInOut)
        }
        .navigationBarTitle("Staggered Grid", displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Button(action: { self.shuffleImages() }) {
                    Text("Shuffle")
                }
                
                Button(action: { self.showSettings = true }) {
                    Image(systemName: "gear")
                }
            }

        )
        .gridStyle(
            self.style
        )
        .sheet(isPresented: $showSettings) {
            StaggeredGridSettingsView(style: self.$style).accentColor(.purple)
        }
    }
    
    func shuffleImages() {
        self.items.shuffle()
    }
}

struct StaggeredGridView_Previews: PreviewProvider {
    static var previews: some View {
        StaggeredGridView()
    }
}
