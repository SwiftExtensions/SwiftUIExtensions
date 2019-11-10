import SwiftUI

@inlinable func itemLength(tracks: Int, spacing: CGFloat, padding: CGFloat, availableLength: CGFloat) -> CGFloat {
    let width = availableLength - padding - (spacing * (CGFloat(tracks) - 1))
    return width / CGFloat(tracks)
}
