import SwiftUI

struct GridStyleKey: EnvironmentKey {
    static let defaultValue: AnyGridStyle = AnyGridStyle(ModularGridStyle(columns: .min(100), rows: .fixed(100)))
}
