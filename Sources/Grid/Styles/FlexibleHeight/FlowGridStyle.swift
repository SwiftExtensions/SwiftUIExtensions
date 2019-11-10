import SwiftUI

/// Flow `Grid` style.
public struct FlowGridStyle: GridStyle {
    let columns: Int = 4
    let spacing: CGFloat = 8
    let padding: EdgeInsets = EdgeInsets.init(top: 8, leading: 8, bottom: 8, trailing: 8)
    let axis: Axis.Set = .vertical
    
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .topLeading) {
                    ForEach(0..<configuration.items.count, id: \.self) { index in
                        configuration.items[index]
                            .frame(
                                width: self.axis == .vertical ? self.columnWidth(
                                    columns: self.columns,
                                    spacing: self.spacing,
                                    padding: self.padding,
                                    scrollDirection: self.axis,
                                    geometrySize: geometry.size
                                ) : nil
                            )
                            .alignmentGuide(.top, computeValue: { _ in configuration.alignmentGuides?.wrappedValue[index]?.y ?? 0 } )
                            .alignmentGuide(.leading, computeValue: { _ in configuration.alignmentGuides?.wrappedValue[index]?.x ?? 0 })
                            .anchorPreference(key: GridItemPreferences.Key.self, value: .bounds) {
                                [GridItemPreferences(index: index, bounds: geometry[$0])]
                            }
                    }
                }
                .frame(width: geometry.size.width)
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
    
    func columnWidth(columns: Int, spacing: CGFloat, padding: EdgeInsets, scrollDirection: Axis.Set, geometrySize: CGSize) -> CGFloat {
        let geometrySizeWidth = scrollDirection == .vertical ? geometrySize.width : geometrySize.height
        let padding = scrollDirection == .vertical ? padding.leading + padding.trailing : padding.top + padding.bottom
        let width = geometrySizeWidth - padding - (spacing * (CGFloat(columns) - 1))
        return width / CGFloat(columns)
    }
}
