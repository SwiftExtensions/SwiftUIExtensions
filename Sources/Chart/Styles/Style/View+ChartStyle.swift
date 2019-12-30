import SwiftUI

extension View {
    /// Sets the style for `Chart` within the environment of `self`.
    public func chartStyle<S>(_ style: S) -> some View where S : ChartStyle {
        self.environment(\.chartStyle, AnyChartStyle(style))
    }
}
