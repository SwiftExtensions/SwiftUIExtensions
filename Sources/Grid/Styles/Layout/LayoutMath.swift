import SwiftUI

func itemLength(tracks: Tracks, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> CGFloat {
    switch tracks {
    case .count(let count):
        return itemLength(tracksCount: count, spacing: spacing, padding: padding, availableLength: availableLength)
    case .fixed(let length):
        return length
    case .min:
        let suggestedTracksCount = tracksCount(tracks: tracks, spacing: spacing, padding: padding, availableLength: availableLength)
        return itemLength(tracksCount: suggestedTracksCount, spacing: spacing, padding: padding, availableLength: availableLength)
    }
}

func tracksCount(tracks: Tracks, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> Int {
    switch tracks {
    case .count(let count):
        return count
    case .fixed(let length):
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
}

func itemLength(tracksCount: Int, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> CGFloat {
    let width = availableLength - padding - (spacing * (CGFloat(tracksCount) - 1))
    return (width / CGFloat(tracksCount))
}
