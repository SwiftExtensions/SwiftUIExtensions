import SwiftUI

struct StaggeredGridLayout {
    let axis: Axis
    let tracks: Tracks
    let spacing: CGFloat
    
    func transform(preferences: inout GridPreferences, in size: CGSize) {
        let computedTracksCount = self.axis == .vertical ?
            tracksCount(
                tracks: self.tracks,
                spacing: self.spacing,
                availableLength: size.width
            ) :
            tracksCount(
                tracks: self.tracks,
                spacing: self.spacing,
                availableLength: size.height
            )

        let itemSize = CGSize(
            width: itemLength(
                tracks: self.tracks,
                spacing: self.spacing,
                availableLength: size.width
            ),
            height: itemLength(
                tracks: self.tracks,
                spacing: self.spacing,
                availableLength: size.height
            )
        )

        preferences = layoutPreferences(
            tracks: computedTracksCount,
            spacing: self.spacing,
            axis: self.axis,
            itemSize: itemSize,
            preferences: preferences
        )
    }
    
    private func layoutPreferences(tracks: Int, spacing: CGFloat, axis: Axis, itemSize: CGSize, preferences: GridPreferences) -> GridPreferences {
        var tracksLengths = Array(repeating: CGFloat(0.0), count: tracks)
        var newPreferences: GridPreferences = GridPreferences(items: [])
        
        preferences.items.forEach { preference in
            if let minValue = tracksLengths.min(), let indexMin = tracksLengths.firstIndex(of: minValue) {
                let itemSizeWidth = axis == .vertical ? itemSize.width : preference.bounds.size.width
                let itemSizeHeight = axis == .vertical ? preference.bounds.size.height : itemSize.height
                let width = axis == .vertical ? itemSizeWidth * CGFloat(indexMin) + CGFloat(indexMin) * spacing : tracksLengths[indexMin]
                let height = axis == .vertical ? tracksLengths[indexMin] : itemSizeHeight * CGFloat(indexMin) + CGFloat(indexMin) * spacing
        
                let origin = CGPoint(x: width, y: height)
                tracksLengths[indexMin] += (axis == .vertical ? itemSizeHeight : itemSizeWidth) + spacing
                print(tracksLengths)
                print(itemSizeWidth, itemSizeHeight)
                newPreferences.merge(with:
                    GridPreferences(items: [GridPreferences.Item(
                        id: preference.id,
                        bounds: CGRect(origin: origin, size: CGSize(width: itemSizeWidth, height: itemSizeHeight))
                    )])
                )
            }
        }

        return newPreferences
    }
}
