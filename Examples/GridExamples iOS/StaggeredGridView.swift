import SwiftUI
import Grid

struct StaggeredGridView: View {
    var body: some View {
        NavigationView {
            Grid(1...69, id: \.self) { index in
                Image("\(index)")
                    .resizable()
                    .scaledToFit()
            }
            .navigationBarTitle("Staggered", displayMode: .inline)
        }
        .gridStyle(
            StaggeredGridStyle(tracks: .auto(.min(100)), axis: .vertical, spacing: 1)
        )
        .navigationViewStyle(
            StackNavigationViewStyle()
        )
    }
}

struct StaggeredGridView_Previews: PreviewProvider {
    static var previews: some View {
        StaggeredGridView()
    }
}
