import SwiftUI

extension EnvironmentValues {
    var valueSliderStyle: AnyValueSliderStyle {
        get {
            return self[ValueSliderStyleKey.self]
        }
        set {
            self[ValueSliderStyleKey.self] = newValue
        }
    }
}
