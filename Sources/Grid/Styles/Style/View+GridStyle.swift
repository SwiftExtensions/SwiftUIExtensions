import SwiftUI

extension View {
    /// Sets the style for `Grid` within the environment of `self`.
    public func gridStyle<S>(_ style: S) -> some View where S : GridStyle {
        self.environment(\.gridStyle, style)
    }
}
