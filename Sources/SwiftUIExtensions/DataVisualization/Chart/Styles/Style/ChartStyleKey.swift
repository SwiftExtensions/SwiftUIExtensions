import SwiftUI

struct ChartStyleKey: EnvironmentKey {
    static let defaultValue: AnyChartStyle = AnyChartStyle(LineChartStyle())
}
