import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension EnvironmentValues {
    var gridStyle: GridStyle {
        get {
            return self[GridStyleKey.self]
        }
        set {
            self[GridStyleKey.self] = newValue
        }
    }
}
