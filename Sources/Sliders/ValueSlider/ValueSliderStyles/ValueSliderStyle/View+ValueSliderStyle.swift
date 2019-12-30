import SwiftUI

extension View {
    /// Sets the style for `ValueSlider` within the environment of `self`.
    public func valueSliderStyle<S>(_ style: S) -> some View where S : ValueSliderStyle {
        self.environment(\.valueSliderStyle, AnyValueSliderStyle(style))
    }
}
