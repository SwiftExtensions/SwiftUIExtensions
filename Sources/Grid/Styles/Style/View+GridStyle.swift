import SwiftUI

public extension View {
    /// Sets the style for `Grid` within the environment of `self`.
    @inlinable func gridStyle<S>(_ style: S) -> some View where S : GridStyle {
        self.environment(\.gridStyle, style)
    }
}
