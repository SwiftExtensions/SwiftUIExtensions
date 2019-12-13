import SwiftUI

public struct AreaChartStyle<Fill: View>: ChartStyle {
    private let lineType: LineType
    private let fill: Fill
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        fill
            .clipShape(
                AreaChart(unitData: configuration.dataMatrix.map { $0.reduce(0, +) }, lineType: self.lineType)
            )
    }
    
    public init(_ lineType: LineType = .quadCurve, fill: Fill) {
        self.lineType = lineType
        self.fill = fill
    }
}
