import SwiftUI

struct GridStyleKey: EnvironmentKey {
    static let defaultValue: GridStyle = ModularGridStyle(columns: .min(100), rows: .min(100))
}
