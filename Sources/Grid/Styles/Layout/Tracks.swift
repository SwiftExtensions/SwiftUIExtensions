import SwiftUI

public enum Tracks {
    case auto(Dimensions)
    case count(Int)
}

extension Tracks: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: Self.IntegerLiteralType) {
        self = .count(value)
    }
}
