import SwiftUI

func itemLength(tracks: Tracks, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> CGFloat {
    switch tracks {
    case .auto(let dimensions):
        switch dimensions {
        case .min:
            let suggestedTracksCount = tracksCount(tracks: tracks, spacing: spacing, padding: padding, availableLength: availableLength)
            return itemLength(tracks: suggestedTracksCount, spacing: spacing, padding: padding, availableLength: availableLength)
        }

    case .count(let count):
        return itemLength(tracks: count, spacing: spacing, padding: padding, availableLength: availableLength)
    }
}

func tracksCount(tracks: Tracks, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> Int {
    switch tracks {
    case .auto(let dimensions):
        switch dimensions {
        case .min(let minWidth):
            let usableAvailableWidth = availableLength - padding
            let columnCount = Int(usableAvailableWidth / minWidth)
            
            for columns in (0...columnCount).reversed() {
                let suggestedItemWidth = itemLength(tracks: columns, spacing: spacing, padding: padding, availableLength: availableLength)
                if (suggestedItemWidth * CGFloat(columns)) + (CGFloat(columns - 1) * spacing) <= usableAvailableWidth {
                    return columns
                }
            }
            return 1
        }
    case .count(let count):
        return count
    }
}
//
//func itemLength(minItemWidth: CGFloat, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> CGFloat {
//    let suggestedTracksCount = tracksCount(tracks: <#T##Tracks#>, spacing: <#T##CGFloat#>, padding: <#T##CGFloat#>, availableLength: <#T##CGFloat#>)
//
//    let usableAvailableWidth = availableLength - padding
//    let columnCount = Int(usableAvailableWidth / minItemWidth)
//
//    for columns in (0...columnCount).reversed() {
//        let suggestedItemWidth = itemLength(tracks: columns, spacing: spacing, padding: padding, availableLength: availableLength)
//        if (suggestedItemWidth * CGFloat(columns)) + (CGFloat(columns - 1) * spacing) <= usableAvailableWidth {
//            return suggestedItemWidth.rounded()
//        }
//    }
//    return usableAvailableWidth.rounded()
//}

func itemLength(tracks: Int, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> CGFloat {
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
