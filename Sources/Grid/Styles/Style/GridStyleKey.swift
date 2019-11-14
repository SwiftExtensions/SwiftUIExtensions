import SwiftUI

struct GridStyleKey: EnvironmentKey {
    static let defaultValue: AnyGridStyle = AnyGridStyle(ModularGridStyle(columns: .auto(.min(100)), rows: .auto(.min(100))))
}
