import SwiftUI

public struct LineChartStyle: ChartStyle {
    private let lineType: LineType
    private let lineColor: Color
    private let lineWidth: CGFloat
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        switch lineType {
        case .line:
            return AnyView(Line(unitData: configuration.dataMatrix.map { $0.reduce(0, +) })
                .stroke(self.lineColor, style: .init(lineWidth: self.lineWidth, lineCap: .round)))
        case .quadCurve:
            return AnyView(QuadCurve(unitData: configuration.dataMatrix.map { $0.reduce(0, +) })
                .stroke(self.lineColor, style: .init(lineWidth: self.lineWidth, lineCap: .round)))
        }
    }
    
    public init(_ lineType: LineType = .quadCurve, lineColor: Color = .accentColor, lineWidth: CGFloat = 1) {
        self.lineType = lineType
        self.lineColor = lineColor
        self.lineWidth = lineWidth
    }
}
