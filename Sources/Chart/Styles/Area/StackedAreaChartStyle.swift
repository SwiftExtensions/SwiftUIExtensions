import SwiftUI

public struct StackedAreaChartStyle: ChartStyle {
    private let lineType: LineType
    private let colors: [Color]
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            ForEach(Array(configuration.dataMatrix.flipDirection().stacked().reversed().enumerated()), id: \.self.offset) { enumeratedData in
                self.colors.prefix(configuration.dataMatrix.count).reversed()[enumeratedData.offset % self.colors.count].clipShape(
                    AreaChart(
                        unitData: enumeratedData.element,
                        lineType: self.lineType
                    )
                )
            }
        }
        .drawingGroup()
    }
    
    public init(_ lineType: LineType = .quadCurve, colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]) {
        self.lineType = lineType
        self.colors = colors
    }
}

extension Collection where Element == [CGFloat] {
    func stacked() -> [[CGFloat]] {
        self.reduce([]) { (result, element) -> [[CGFloat]] in
            if let lastElement = result.last {
                return result + [zip(lastElement, element).compactMap(+)]
            } else {
                return [element]
            }
        }
    }
}

extension Array where Element == [CGFloat] {
    func flipDirection() -> [[CGFloat]] {
        let columnsCount = self.first?.count ?? 0
        let rowCount = self.count
        
        return (0..<columnsCount).map { columnIndex in
            (0..<rowCount).map { rowIndex in
                return self[rowIndex][columnIndex]
            }.reversed()
        }
    }
}
