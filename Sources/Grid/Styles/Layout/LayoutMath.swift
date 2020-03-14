import SwiftUI

func itemLength(tracks: Tracks, spacing: CGFloat, availableLength: CGFloat) -> CGFloat {
    switch tracks {
    case .count(let count):
        return itemLength(tracksCount: count, spacing: spacing, availableLength: availableLength)
    case .fixed(let length):
        return length
    case .min:
        let suggestedTracksCount = tracksCount(tracks: tracks, spacing: spacing, availableLength: availableLength)
        return itemLength(tracksCount: suggestedTracksCount, spacing: spacing, availableLength: availableLength)
    }
}

func tracksCount(tracks: Tracks, spacing: CGFloat, availableLength: CGFloat) -> Int {
    switch tracks {
    case .count(let count):
        return count
    case .fixed(let length):
        let columnCount = Int(availableLength / length)
        
        for columns in (0...columnCount).reversed() {
            let suggestedItemWidth = itemLength(tracksCount: columns, spacing: spacing, availableLength: availableLength)
            if (suggestedItemWidth * CGFloat(columns)) + (CGFloat(columns - 1) * spacing) <= availableLength {
                return columns
            }
        }
        return 1
    case .min(let minWidth):
        let columnCount = Int(availableLength / minWidth)
        
        for columns in (0...columnCount).reversed() {
            let suggestedItemWidth = itemLength(tracksCount: columns, spacing: spacing, availableLength: availableLength)
            if (suggestedItemWidth * CGFloat(columns)) + (CGFloat(columns - 1) * spacing) <= availableLength {
                return columns
            }
        }
        return 1
    }
}

func itemLength(tracksCount: Int, spacing: CGFloat, availableLength: CGFloat) -> CGFloat {
    let width = availableLength - (spacing * (CGFloat(tracksCount) - 1))
    return (width / CGFloat(tracksCount))
}
