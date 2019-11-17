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
            .navigationBarTitle("Staggered Grid", displayMode: .inline)
        }
        .gridStyle(
            StaggeredGridStyle(tracks: .auto(.min(100)), axis: .vertical, spacing: 1, padding: .init(top: 1, leading: 1, bottom: 1, trailing: 1))
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
