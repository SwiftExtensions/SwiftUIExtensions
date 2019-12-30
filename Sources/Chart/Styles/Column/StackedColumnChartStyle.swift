import SwiftUI

public struct StackedColumnChartStyle<Column: View>: ChartStyle {
    private let spacing: CGFloat
    private let column: ([CGFloat]) -> Column
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        GeometryReader { geometry in
            self.columnChart(in: geometry, data: configuration.dataMatrix)
        }
    }
    
    private func columnChart(in geometry: GeometryProxy, data: [[CGFloat]]) -> some View {
        let columnWidth = (geometry.size.width - (CGFloat(data.count - 1) * spacing)) / CGFloat(data.count)
    
        return ZStack(alignment: .bottomLeading) {
            ForEach(Array(data.enumerated()), id: \.self.offset) { enumeratedData in
                self.column(enumeratedData.element)
                    .alignmentGuide(.leading, computeValue: { _ in self.leadingAlignmentGuide(for: enumeratedData.offset, in: geometry.size.width, dataCount: data.count) })
                    .alignmentGuide(.bottom, computeValue: { _ in self.columnHeight(data: enumeratedData.element, in: geometry.size.height) })
                    .frame(width: columnWidth, height: self.columnHeight(data: enumeratedData.element, in: geometry.size.height))
            }
        }
        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
    }
    
    private func columnHeight(data: [CGFloat], in availableHeight: CGFloat) -> CGFloat {
        availableHeight * data.reduce(0, +)
    }
    
    private func leadingAlignmentGuide(for index: Int, in availableWidth: CGFloat, dataCount: Int) -> CGFloat {
        let columnWidth = (availableWidth - (CGFloat(dataCount - 1) * spacing)) / CGFloat(dataCount)
        return (CGFloat(index) * columnWidth) + (CGFloat(index - 1) * spacing)
    }
    
    init(spacing: CGFloat = 8, column: @escaping ([CGFloat]) -> Column) {
        self.spacing = spacing
        self.column = column
    }
}

public struct DefaultStackedColumnView: View {
    let data: [CGFloat]
    let colors: [Color]
    
    public var body: some View {
        GeometryReader { geometry in
            self.column(for: self.data, in: geometry)
        }
    }
    
    private func column(for data: [CGFloat], in geometry: GeometryProxy) -> some View {
        let height = geometry.size.height
        let dataUnit = data.reduce(0, +)
        
        return VStack(spacing: 0) {
            ForEach(Array(self.data.reversed().enumerated()), id: \.self.offset) { enumeratedData in
                Rectangle()
                    .foregroundColor(self.color(at: enumeratedData.offset))
                    .frame(height: height * (enumeratedData.element / dataUnit))
            }
        }
    }
    
    private func color(at rollingIndex: Int) -> Color {
        self.colors.prefix(self.data.count).reversed()[rollingIndex % self.colors.count]
    }
}

public extension StackedColumnChartStyle where Column == DefaultStackedColumnView {
    init(spacing: CGFloat = 8, colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]) {
        self.init(spacing: spacing, column: { DefaultStackedColumnView(data: $0, colors: colors) })
    }
}
