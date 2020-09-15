import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    /// Sets the style for `Grid` within the environment of `self`.
    @inlinable func gridStyle<S>(_ style: S) -> some View where S : GridStyle {
        self.environment(\.gridStyle, style)
    }
}
