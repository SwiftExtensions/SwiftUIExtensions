import SwiftUI
import Grid

struct StaggeredGridView: View {
    var body: some View {
        NavigationView {
            Grid(1...70) { number in
                Image("\(number)")
                    .resizable()
                    .scaledToFit()
            }
            .navigationBarTitle("Staggered")
        }
        .gridStyle(
            ModularGridStyle(columns: 3, rows: 3)
            //StaggeredGridStyle(tracks: 3)
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
