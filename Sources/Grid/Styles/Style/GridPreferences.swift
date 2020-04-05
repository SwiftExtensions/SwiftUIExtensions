import Foundation
import CoreGraphics

public struct GridPreferences: Equatable {
    public struct Item: Equatable {
        public let id: AnyHashable
        public let bounds: CGRect
        
        public init(id: AnyHashable, bounds: CGRect) {
            self.id = id
            self.bounds = bounds
        }
    }
    
    public var items: [Item]

    public var size: CGSize

    public init(size: CGSize = .zero, items: [Item]) {
        self.size = size
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
            width: (self.items.map { $0.bounds.origin.x + $0.bounds.size.width }.max() ?? 0.0).rounded(),
            height: (self.items.map { $0.bounds.origin.y + $0.bounds.size.height }.max() ?? 0.0).rounded()
        )
    }
}
