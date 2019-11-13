import SwiftUI

@inlinable func itemLength(tracks: Int, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> CGFloat {
    let width = availableLength - padding - (spacing * (CGFloat(tracks) - 1))
    return (width / CGFloat(tracks)).rounded()
}

@inlinable func alignmentGuides(tracks: Int, spacing: CGFloat, axis: Axis.Set, preferences: [GridItemPreferences]) -> [Int: CGPoint] {
    var heights = Array(repeating: CGFloat(0), count: tracks)
    var alignmentGuides: [Int: CGPoint] = [:]

    preferences.forEach { preference in
        if let minValue = heights.min(), let indexMin = heights.firstIndex(of: minValue) {
            let size = preference.bounds.size
            let preferenceSizeWidth = axis == .vertical ? size.width : size.height
            let preferenceSizeHeight = axis == .vertical ? size.height : size.width
            let width = preferenceSizeWidth * CGFloat(indexMin) + CGFloat(indexMin) * spacing
            let height = heights[indexMin]
            let offset = CGPoint(
                x: (0 - (axis == .vertical ? width : height)).rounded(),
                y: (0 - (axis == .vertical ? height : width)).rounded()
            )
            heights[indexMin] += preferenceSizeHeight + spacing
            alignmentGuides[preference.index] = offset
        }
    }

    return alignmentGuides
}
