import SwiftUI

public enum Dimensions {
    case fixedSize(CGFloat)
    case min(CGFloat)
}

extension Dimensions: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Float

    public init(floatLiteral value: Self.FloatLiteralType) {
        self = .fixedSize(CGFloat(value))
    }
}

extension Dimensions: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: Self.IntegerLiteralType) {
        self = .fixedSize(CGFloat(value))
    }
}
