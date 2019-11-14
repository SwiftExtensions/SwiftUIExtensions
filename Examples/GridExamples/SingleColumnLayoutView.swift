import SwiftUI
import Grid

struct SingleColumnLayoutView: View {
    var body: some View {
        Grid {
            Card(title: "1")
            Card(title: "2")
            Card(title: "3")
            Card(title: "4")
            Card(title: "5")
            Card(title: "6")
            Card(title: "7")
            Card(title: "8")
            Card(title: "9")
            Card(title: "10")
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
