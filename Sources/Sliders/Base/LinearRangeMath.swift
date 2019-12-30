import Foundation
import SwiftUI

/// Calculates range distance in points
@inlinable func rangeDistance(overallLength: CGFloat, range: ClosedRange<CGFloat>, bounds: ClosedRange<CGFloat> = 0.0...1.0, lowerStartOffset: CGFloat = 0, lowerEndOffset: CGFloat = 0, upperStartOffset: CGFloat = 0, upperEndOffset: CGFloat = 0) -> CGFloat {
    let offsetLowerValue = distanceFrom(value: range.lowerBound, availableDistance: overallLength, bounds: bounds, leadingOffset: lowerStartOffset, trailingOffset: lowerEndOffset)
    let offsetUpperValue = distanceFrom(value: range.upperBound, availableDistance: overallLength, bounds: bounds, leadingOffset: upperStartOffset, trailingOffset: upperEndOffset)
    return offsetUpperValue - offsetLowerValue
}
