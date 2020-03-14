import SwiftUI
import Grid

struct StaggeredGridView: View {
    @State var showSettings: Bool = false
    @State var style = StaggeredGridStyle(.horizontal, tracks: 5, spacing: 4)
    
    var body: some View {
        VStack(alignment: .trailing) {
            Button(action: { self.showSettings = true }) {
                Text("Settings")
            }
        
            ScrollView(style.axes) {
                Grid(1...69, id: \.self) { index in
                    Image("\(index)")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(8)
            }
            
        }
        .sheet(isPresented: self.$showSettings) {
            StaggeredGridSettingsView(style: self.$style)
        }
        .gridStyle(
            self.style
        )
    }
}

struct StaggeredGridView_Previews: PreviewProvider {
    static var previews: some View {
        StaggeredGridView()
    }
}
