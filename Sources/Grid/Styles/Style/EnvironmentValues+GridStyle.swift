import SwiftUI

public extension EnvironmentValues {
    var gridStyle: AnyGridStyle {
        get {
            return self[GridStyleKey.self]
        }
        set {
            self[GridStyleKey.self] = newValue
        }
    }
}
