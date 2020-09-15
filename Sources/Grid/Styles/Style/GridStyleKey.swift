import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct GridStyleKey: EnvironmentKey {
    static let defaultValue: GridStyle = ModularGridStyle(columns: .min(100), rows: .fixed(100))
}
