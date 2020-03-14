import Foundation
import SwiftUI

public struct GridPreferences: Equatable {
    public struct Item: Equatable {
        public let id: AnyHashable
        public let bounds: CGRect
    }
    
    public var items: [Item]

    public var size: CGSize = .zero

    public init(items: [Item]) {
        self.items = items
    }
    
    subscript(id: AnyHashable) -> Item? {
        get {
            items.first(where: { $0.id == id })
        }
    }
    
    mutating func merge(with preferences: GridPreferences) {
        self.items.append(contentsOf: preferences.items)
        self.size = CGSize(
            width: max(self.size.width, abs(self.items.map { $0.bounds.origin.x - $0.bounds.size.width }.min() ?? 0.0).rounded()),
            height: max(self.size.height, abs(self.items.map { $0.bounds.origin.y - $0.bounds.size.height }.min() ?? 0.0).rounded())
        )
    }
}

public struct GridPreferencesKey: PreferenceKey {
    public static var defaultValue: GridPreferences = .init(items: [])
    
    public static func reduce(value: inout GridPreferences, nextValue: () -> GridPreferences) {
        value.merge(with: nextValue())
    }
}
