import Foundation
import SwiftUI

public struct GridItemPreferences: Equatable {
    public static func == (lhs: GridItemPreferences, rhs: GridItemPreferences) -> Bool {
        lhs.index == rhs.index && lhs.bounds == rhs.bounds
    }
    
    public struct Key: PreferenceKey {
        public static var defaultValue: [GridItemPreferences] = []
        
        public static func reduce(value: inout [GridItemPreferences], nextValue: () -> [GridItemPreferences]) {
            value.append(contentsOf: nextValue())
        }
    }
    
    public let index: Int
    public let bounds: CGRect
    public let anchor: Anchor<CGRect>
}
