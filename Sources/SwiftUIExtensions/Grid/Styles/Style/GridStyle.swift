import SwiftUI

/// A specification for the appearance of a `Grid`.
public protocol GridStyle {
    var padding: EdgeInsets { get }
    var axis: Axis { get }
    var autoWidth: Bool { get }
    var autoHeight: Bool { get }
    func transform(preferences: inout [GridItemPreferences], in size: CGSize)
}
