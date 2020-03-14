import SwiftUI

/// A specification for the appearance of a `Grid`.
public protocol GridStyle {
    var axis: Axis { get }
    var autoWidth: Bool { get }
    var autoHeight: Bool { get }
    func transform(preferences: inout GridPreferences, in size: CGSize)
}

public extension GridStyle {
    var axes: Axis.Set {
        self.axis == .horizontal ? .horizontal : .vertical
    }
}
