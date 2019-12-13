import SwiftUI

extension EnvironmentValues {
    var chartStyle: AnyChartStyle {
        get {
            return self[ChartStyleKey.self]
        }
        set {
            self[ChartStyleKey.self] = newValue
        }
    }
}
