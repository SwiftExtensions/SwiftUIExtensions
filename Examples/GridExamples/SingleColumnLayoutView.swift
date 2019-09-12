import SwiftUI
import Grid

struct SingleColumnLayoutView: View {
    var body: some View {
        Grid(0...100) { number in
            Card(title: "\(number)")
        }
        .padding()
        .gridStyle(
            SingleColumnGridStyle(itemHeight: 120)
        )
    }
}

#if DEBUG
struct OneColumnLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        SingleColumnLayoutView()
    }
}
#endif
