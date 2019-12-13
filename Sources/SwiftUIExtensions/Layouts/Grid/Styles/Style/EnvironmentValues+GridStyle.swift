import SwiftUI

extension EnvironmentValues {
    var gridStyle: GridStyle {
        get {
            return self[GridStyleKey.self]
        }
        set {
            self[GridStyleKey.self] = newValue
        }
    }
}
