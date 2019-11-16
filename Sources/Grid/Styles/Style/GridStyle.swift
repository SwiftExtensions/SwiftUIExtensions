import SwiftUI

/// A specification for the appearance of a `Grid`.
public protocol GridStyle {
    var padding: EdgeInsets { get }
    var layoutAnimation: Animation? { get }
    func transform(preferences: inout [GridItemPreferences], in geometry: GeometryProxy)
}
