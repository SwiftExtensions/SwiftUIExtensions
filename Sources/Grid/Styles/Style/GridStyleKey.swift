import SwiftUI

struct GridStyleKey: EnvironmentKey {
    static let defaultValue: GridStyle = ModularGridStyle(columns: .auto(.min(100)), rows: .auto(.min(100)))
}
