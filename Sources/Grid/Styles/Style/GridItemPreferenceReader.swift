import SwiftUI

struct GridItemPreferenceReader<ID: Hashable>: View {
    let id: ID
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: GridItemPreferencesKey.self, value:
                [GridItemPreferences(id: AnyHashable(self.id))]
            )
        }

    }
}
