import SwiftUI

/// Defines the implementation of all `Chart` instances within a view
/// hierarchy.
///
/// To configure the current `Chart` for a view hiearchy, use the
/// `.chartStyle()` modifier.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol ChartStyle {
    /// A `View` representing the body of a `Chart`.
    associatedtype Body : View

    /// Creates a `View` representing the body of a `Chart`.
    ///
    /// - Parameter configuration: The properties of the value slider instance being
    ///   created.
    ///
    /// This method will be called for each instance of `Chart` created within
    /// a view hierarchy where this style is the current `ChartStyle`.
    func makeBody(configuration: Self.Configuration) -> Self.Body

    /// The properties of a `Chart` instance being created.
    typealias Configuration = ChartStyleConfiguration
}
