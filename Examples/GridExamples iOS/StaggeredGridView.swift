import SwiftUI
import Grid

struct StaggeredGridView: View {
    var body: some View {
        Grid(1...70) { number in
            Image("\(number)")
                .resizable()
                .scaledToFit()
        }
        .gridStyle(
            ModularGridStyle(columns: 3, rows: 3)
            //StaggeredGridStyle(tracks: 3)
        )
    }
}

struct StaggeredGridView_Previews: PreviewProvider {
    static var previews: some View {
        StaggeredGridView()
    }
}
