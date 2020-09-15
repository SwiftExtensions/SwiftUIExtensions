import SwiftUI

/// A specification for the appearance of a `Grid`.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol GridStyle {
    var axis: Axis { get }
    var autoWidth: Bool { get }
    var autoHeight: Bool { get }
    func transform(preferences: inout GridPreferences, in size: CGSize)
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension GridStyle {
    var axes: Axis.Set {
        self.axis == .horizontal ? .horizontal : .vertical
    }
}
