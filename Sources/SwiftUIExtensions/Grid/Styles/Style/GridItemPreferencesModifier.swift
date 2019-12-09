import SwiftUI

struct GridItemPreferencesModifier: View {
    let id: AnyHashable
    let bounds: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            Color
                .clear
                .preference(key: GridItemPreferencesKey.self, value:
                    [GridItemPreferences(
                        id: self.id,
                        bounds: CGRect(origin: self.bounds.origin, size: geometry.size)
                    )]
                )
        }

    }
}
