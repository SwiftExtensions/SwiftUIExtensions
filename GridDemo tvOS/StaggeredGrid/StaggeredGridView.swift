import SwiftUI
import Grid

struct StaggeredGridView: View {
    var body: some View {
        Grid(1...69, id: \.self) { index in
            Image("\(index)")
                .resizable()
                .scaledToFit()
        }
        .gridStyle(
            StaggeredGridStyle(tracks: .min(200))
        )
        .navigationBarTitle("Staggered Grid")
    }
}

struct StaggeredGridView_Previews: PreviewProvider {
    static var previews: some View {
        StaggeredGridView()
    }
}
