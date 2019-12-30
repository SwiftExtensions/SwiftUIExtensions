import SwiftUI

public struct ValueTrackConfiguration {
    public static let defaultConfiguration = ValueTrackConfiguration()
    
    public let leadingOffset: CGFloat
    public let trailingOffset: CGFloat
    
    public init(leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.leadingOffset = leadingOffset
        self.trailingOffset = trailingOffset
    }
}

public extension ValueTrackConfiguration {
    init(offsets: CGFloat = 0) {
        self.leadingOffset = offsets
        self.trailingOffset = offsets
    }
}
