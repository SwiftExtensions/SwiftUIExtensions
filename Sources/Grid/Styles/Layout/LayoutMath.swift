import SwiftUI

func itemLength(tracks: Tracks, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> CGFloat {
    switch tracks {
    case .auto(let dimensions):
        switch dimensions {
        case .fixedSize(let length):
            return length
        case .min:
            let suggestedTracksCount = tracksCount(tracks: tracks, spacing: spacing, padding: padding, availableLength: availableLength)
            return itemLength(tracksCount: suggestedTracksCount, spacing: spacing, padding: padding, availableLength: availableLength)
        }

    case .count(let count):
        return itemLength(tracksCount: count, spacing: spacing, padding: padding, availableLength: availableLength)
    }
}

func tracksCount(tracks: Tracks, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> Int {
    switch tracks {
    case .auto(let dimensions):
        switch dimensions {
        case .fixedSize(let length):
            let usableAvailableWidth = availableLength - padding
            let columnCount = Int(usableAvailableWidth / length)
            
            for columns in (0...columnCount).reversed() {
                let suggestedItemWidth = itemLength(tracksCount: columns, spacing: spacing, padding: padding, availableLength: availableLength)
                if (suggestedItemWidth * CGFloat(columns)) + (CGFloat(columns - 1) * spacing) <= usableAvailableWidth {
                    return columns
                }
            }
            return 1
        case .min(let minWidth):
            let usableAvailableWidth = availableLength - padding
            let columnCount = Int(usableAvailableWidth / minWidth)
            
            for columns in (0...columnCount).reversed() {
                let suggestedItemWidth = itemLength(tracksCount: columns, spacing: spacing, padding: padding, availableLength: availableLength)
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

func itemLength(tracksCount: Int, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> CGFloat {
    let width = availableLength - padding - (spacing * (CGFloat(tracksCount) - 1))
    return (width / CGFloat(tracksCount))
}

//@inlinable func alignmentGuides(tracks: Int, spacing: CGFloat, axis: Axis.Set, preferences: [GridItemPreferences], geometry: GeometryProxy) -> [Int: CGPoint] {
//    var heights = Array(repeating: CGFloat(0), count: tracks)
//    var alignmentGuides: [Int: CGPoint] = [:]
//
//    preferences.forEach { preference in
//        if let minValue = heights.min(), let indexMin = heights.firstIndex(of: minValue) {
//            let size = geometry[preference.boundsAnchor].size
//            let preferenceSizeWidth = axis == .vertical ? size.width : size.height
//            let preferenceSizeHeight = axis == .vertical ? size.height : size.width
//            let width = preferenceSizeWidth * CGFloat(indexMin) + CGFloat(indexMin) * spacing
//            let height = heights[indexMin]
//            let offset = CGPoint(
//                x: 0 - (axis == .vertical ? width : height),
//                y: 0 - (axis == .vertical ? height : width)
//            )
//            heights[indexMin] += preferenceSizeHeight + spacing
//            alignmentGuides[preference.index] = offset
//        }
//    }
//
//    return alignmentGuides
//}


@inlinable func gridAlignmentGuides(tracks: Int, spacing: CGFloat, axis: Axis.Set, size: CGSize, viewsCount: Int, geometry: GeometryProxy, preferences: [GridItemPreferences]) -> [GridItemPreferences] {
    guard !preferences.isEmpty else { return [] }
    var heights = Array(repeating: CGFloat(0), count: tracks)
    var alignmentGuides: [GridItemPreferences] = []

    (0..<viewsCount).forEach { index in
        if let minValue = heights.min(), let indexMin = heights.firstIndex(of: minValue) {
            //let size = geometry[preference.anchor].size
            let preferenceSizeWidth = axis == .vertical ? size.width : size.height
            let preferenceSizeHeight = axis == .vertical ? size.height : size.width
            let width = preferenceSizeWidth * CGFloat(indexMin) + CGFloat(indexMin) * spacing
            let height = heights[indexMin]
            let offset = CGPoint(
                x: 0 - (axis == .vertical ? width : height),
                y: 0 - (axis == .vertical ? height : width)
            )
            heights[indexMin] += preferenceSizeHeight + spacing
            alignmentGuides.append(GridItemPreferences(index: index, prefferedItemSize: preferences[index].prefferedItemSize, origin: offset, itemWidth: size.width, itemHeight: size.height))
        }
    }

    return alignmentGuides
}
