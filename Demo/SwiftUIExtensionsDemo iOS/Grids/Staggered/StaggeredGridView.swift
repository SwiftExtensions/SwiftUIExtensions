import SwiftUI
import SwiftUIExtensions

struct StaggeredGridView: View {
    @State var showSettings: Bool = false
    @State var style = StaggeredGridStyle(tracks: .min(100), axis: .vertical, spacing: 1, padding: .init(top: 1, leading: 1, bottom: 1, trailing: 1))
    
    var body: some View {
        Grid(1...69, id: \.self) { index in
            Image("\(index)")
                .resizable()
                .scaledToFit()
        }
        .navigationBarTitle("Staggered Grid", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: { self.showSettings = true }) {
                Image(systemName: "gear")
            }
        )
        .gridStyle(
            self.style
        )
        .sheet(isPresented: $showSettings) {
            StaggeredGridSettingsView(style: self.$style).accentColor(.purple)
        }
    }
}

struct StaggeredGridView_Previews: PreviewProvider {
    static var previews: some View {
        StaggeredGridView()
    }
}
