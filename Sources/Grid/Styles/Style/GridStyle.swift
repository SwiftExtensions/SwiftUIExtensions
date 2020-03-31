import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol GridStyle {
    /// A `View` representing the body of a `ValueSlider`.
    associatedtype Body : View
    
    /// Creates a `View` representing the body of a `ValueSlider`.
    ///
    /// - Parameter configuration: The properties of the value slider instance being
    ///   created.
    ///
    /// This method will be called for each instance of `ValueSlider` created within
    /// a view hierarchy where this style is the current `ValueSliderStyle`.
    func makeBody(configuration: Self.Configuration) -> Self.Body

    /// The properties of a `ValueSlider` instance being created.
    typealias Configuration = GridStyleConfiguration
}
