import SwiftUI

/// Staggered `Grid` style.
public struct ModularGridStyle: GridStyle {
    let columns: Int = 1
    let spacing: CGFloat = 8
    let padding: EdgeInsets = EdgeInsets.init(top: 8, leading: 8, bottom: 8, trailing: 8)
    
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .topLeading) {
                    ForEach(0..<configuration.items.count, id: \.self) { index in
                        configuration.items[index]
                            .frame(
                                width: itemLength(
                                    tracks: self.columns,
                                    spacing: self.spacing,
                                    padding: self.padding.leading + self.padding.trailing,
                                    availableLength: geometry.size.width
                                ),
                                height: 160
                            )
                            .alignmentGuide(.top, computeValue: { _ in configuration.alignmentGuides?.wrappedValue[index]?.y ?? 0 } )
                            .alignmentGuide(.leading, computeValue: { _ in configuration.alignmentGuides?.wrappedValue[index]?.x ?? 0 })
                            .anchorPreference(key: GridItemPreferences.Key.self, value: .bounds) {
                                [GridItemPreferences(index: index, bounds: geometry[$0])]
                            }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(self.padding)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onPreferenceChange(GridItemPreferences.Key.self) { preferences in
                configuration.alignmentGuides?.wrappedValue = self.alignmentGuides(tracks: self.columns, spacing: self.spacing, axis: .vertical, preferences: preferences)
            }
        }

    }
    
    func alignmentGuides(tracks: Int, spacing: CGFloat, axis: Axis.Set, preferences: [GridItemPreferences]) -> [Int: CGPoint] {
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
                    x: 0 - (axis == .vertical ? width : height),
                    y: 0 - (axis == .vertical ? height : width)
                )
                heights[indexMin] += preferenceSizeHeight + spacing
                alignmentGuides[preference.index] = offset
            }
        }

        return alignmentGuides
    }
    

}
