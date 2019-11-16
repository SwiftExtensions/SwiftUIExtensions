import Foundation
import SwiftUI

public struct GridItemPreferences: Equatable {
    public let id: AnyHashable    
    public var origin: CGPoint?
    public var itemWidth: CGFloat?
    public var itemHeight: CGFloat?
}
