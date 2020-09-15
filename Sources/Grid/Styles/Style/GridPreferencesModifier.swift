import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct GridPreferencesModifier: View {
    let id: AnyHashable
    let bounds: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            Color
                .clear
                .preference(key: GridPreferencesKey.self, value:
                    GridPreferences(items: [
                        GridPreferences.Item(id: self.id, bounds: CGRect(origin: self.bounds.origin, size: geometry.size))
                    ])
                )
        }

    }
}
