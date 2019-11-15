import SwiftUI

/// A specification for the appearance of a `Grid`.
public protocol GridStyle {
    var padding: EdgeInsets { get }
    func itemPreferences(with geometry: GeometryProxy, itemsCount: Int, preferences: [GridItemPreferences]) -> [GridItemPreferences]
}
