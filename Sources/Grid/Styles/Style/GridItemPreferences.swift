import Foundation
import SwiftUI

public struct GridItemPreferences: Equatable {    
    public let index: Int
    public let prefferedItemSize: CGSize
    
    public var origin: CGPoint?
    
    
    public var itemWidth: CGFloat?
    public var itemHeight: CGFloat?
    
    public init(index: Int, prefferedItemSize: CGSize, origin: CGPoint? = nil, itemWidth: CGFloat? = nil, itemHeight: CGFloat? = nil) {
        self.index = index
        self.prefferedItemSize = prefferedItemSize
        self.origin = origin
        self.itemWidth = itemWidth
        self.itemHeight = itemHeight
    }
    
    public static func == (lhs: GridItemPreferences, rhs: GridItemPreferences) -> Bool {
        lhs.index == rhs.index &&
        //lhs.prefferedItemSize == rhs.prefferedItemSize &&
        lhs.origin == rhs.origin &&
        lhs.itemWidth == rhs.itemWidth &&
        lhs.itemHeight == rhs.itemHeight
    }
}
