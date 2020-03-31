import SwiftUI
import Grid

struct StaticGridView: View {
    var body: some View {
        ScrollView {
            Grid {
                Capsule().foregroundColor(.random)
                Capsule().foregroundColor(.random)
                Capsule().foregroundColor(.random)
                Capsule().foregroundColor(.random)
                Capsule().foregroundColor(.random)
                Capsule().foregroundColor(.random)
                Capsule().foregroundColor(.random)
                Capsule().foregroundColor(.random)
                Capsule().foregroundColor(.random)
                Capsule().foregroundColor(.random)
            }
            .padding(16)
            .frame(height: 300)
        }
        .gridStyle(
            ModularGridStyle(columns: 5, rows: 2, spacing: 16)
        )
    }
}

struct StaticGridView_Previews: PreviewProvider {
    static var previews: some View {
        StaticGridView()
    }
}
