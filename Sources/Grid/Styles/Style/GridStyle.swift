import SwiftUI

/// A specification for the appearance of a `Grid`.
public protocol GridStyle {
    /// A `View` representing the body of a `Grid`.
    associatedtype Body : View

    /// Creates a `View` representing the body of a `Grid`.
    ///
    /// - Parameter configuration: The properties of the value slider instance being
    ///   created.
    ///
    /// This method will be called for each instance of `Grid` created within
    /// a view hierarchy where this style is the current `GridStyle`.
    func makeBody(configuration: Self.Configuration) -> Self.Body

    /// The properties of a `Grid` instance being created.
    typealias Configuration = GridStyleConfiguration
}
