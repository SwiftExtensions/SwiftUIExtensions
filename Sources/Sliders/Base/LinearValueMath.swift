import Foundation
import SwiftUI

/// Linear calculations

/// Calculates distance from zero in points
@inlinable func distanceFrom(value: CGFloat, availableDistance: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) -> CGFloat {
    let boundsLenght = bounds.upperBound - bounds.lowerBound
    let relativeValue = (value - bounds.lowerBound) / boundsLenght
    let offset = (leadingOffset - ((leadingOffset + trailingOffset) * relativeValue))
    return offset + (availableDistance * relativeValue)
}

/// Calculates value for relative point in bounds with step.
/// Example: For relative value 0.5 in range 2.0..4.0 produces 3.0
@inlinable func valueFrom(distance: CGFloat, availableDistance: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, step: CGFloat = 0.001, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) -> CGFloat {
    let relativeValue = (distance - leadingOffset) / (availableDistance - (leadingOffset + trailingOffset))
    let newValue = bounds.lowerBound + (relativeValue * (bounds.upperBound - bounds.lowerBound))
    let steppedNewValue = (round(newValue / step) * step)
    let validatedValue = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))
    return validatedValue
}






//// Deprications

/// Return a relative value for value in bounds
/// Example: For value 3.0 in bounds 2.0...4.0 returns 0.5
@inlinable func relativeValueFrom(value: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0) -> CGFloat {
    let boundsLenght = bounds.upperBound - bounds.lowerBound
    return (value - bounds.lowerBound) / boundsLenght
}

/// Calculates relative position from 0.0 to 1.0 in given lenght where zero offset is in the center.
/// Example: For offset 0 in lenght 100 returns 0.5
@inlinable func relativeValueFrom(overallLength: CGFloat, centerOffset: CGFloat) -> CGFloat {
    (centerOffset + (overallLength / 2)) / overallLength
}

/// Calculates value for relative point in bounds with step.
/// Example: For relative value 0.5 in range 2.0..4.0 produces 3.0
@inlinable func valueFrom(relativeValue: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, step: CGFloat = 0.001) -> CGFloat {
    let newValue = bounds.lowerBound + (relativeValue * (bounds.upperBound - bounds.lowerBound))
    let steppedNewValue = (round(newValue / step) * step)
    let validatedValue = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))
    return validatedValue
}

/// Available length should pass width minus slider length.
@inlinable func offsetFromCenterToValue(overallLength: CGFloat, value: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, startOffset: CGFloat = 0, endOffset: CGFloat = 0) -> CGFloat {
    let computedRelativeValue = relativeValueFrom(value: value, bounds: bounds)
    let offset = (startOffset - ((startOffset + endOffset) * computedRelativeValue))
    return offset + (computedRelativeValue * overallLength) - (overallLength / 2)
}

/// Range


