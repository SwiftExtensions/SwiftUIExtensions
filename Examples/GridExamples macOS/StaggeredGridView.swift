import SwiftUI
import Grid

struct StaggeredGridView: View {
    var body: some View {
        Grid(1...69, id: \.self) { index in
            Image("\(index)")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .gridStyle(
            StaggeredGridStyle(tracks: 5, axis: .horizontal, spacing: 4)
        )
    }
}

struct StaggeredGridView_Previews: PreviewProvider {
    static var previews: some View {
        StaggeredGridView()
    }
}
