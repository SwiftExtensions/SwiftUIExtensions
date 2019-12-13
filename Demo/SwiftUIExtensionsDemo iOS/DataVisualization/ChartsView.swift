import SwiftUI
import SwiftUIExtensions

struct ChartsView: View {
    @State var data1: [CGFloat] = (2010...2020).map { _ in .random(in: 0.1...1.0) }
    @State var data2: [CGFloat] = (0..<50).map { _ in .random(in: 0.1...1.0) }
    @State var data3: [CGFloat] = (0..<100).map { _ in .random(in: 0.1...1.0) }
    
    @State var data4: [CGFloat] = (0..<100).map { _ in .random(in: 0.4...1.0) }
    @State var data5: [CGFloat] = (0..<100).map { _ in .random(in: 0.1...0.3) }
    @State var data6: [CGFloat] = (0..<100).map { _ in .random(in: 0.3...0.4) }
    
    @State var matrixData1: [[CGFloat]] = (0..<20).map { _ in (0..<3).map { _ in CGFloat.random(in: 0.00...0.33) } }
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    AxisLabels(.vertical, data: 1...10, id: \.self) {
                        Text("\(110 - $0 * 10)")
                            .fontWeight(.bold)
                            .font(Font.system(size: 8))
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 20)
                    
                    Rectangle().foregroundColor(.clear).frame(width: 20, height: 20)
                }

                
                VStack {
                    Chart(data: data1)
                        .chartStyle(
                            LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 5)
                        )
                        .padding()
                        .background(
                            GridPattern(horizontalLines: 10 + 1, verticalLines: data1.count + 1)
                                .inset(by: 1)
                                .stroke(Color.gray.opacity(0.1), style: .init(lineWidth: 2, lineCap: .round))
                        )
                        .frame(height: 300)
                    
                    
                    AxisLabels(.horizontal, data: 2010...2020, id: \.self) {
                        Text("\($0)".replacingOccurrences(of: ",", with: ""))
                            .fontWeight(.bold)
                            .font(Font.system(size: 8))
                            .foregroundColor(.secondary)
                    }
                    .frame(height: 20)
                    .padding(.horizontal, 1)
                }
                .layoutPriority(1)
            }

            .padding()

            
            Chart(data: data2)
                .chartStyle(
                    AreaChartStyle(.quadCurve, fill:
                        LinearGradient(gradient: .init(colors: [Color.red.opacity(0.8), Color.red.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                    )
                )
                .background(
                    Color.gray.opacity(0.1)
                        .overlay(
                            GridPattern(horizontalLines: data2.count)
                                .inset(by: 1)
                                .stroke(Color.red.opacity(0.2), style: .init(lineWidth: 1, lineCap: .round))
                        )
                )
                .cornerRadius(16)
                .frame(height: 300)
                .padding()
            
            Chart(data: data3)
                .chartStyle(
                    ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
                )
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .frame(height: 300)
                .padding()
            
            Chart(data: matrixData1)
                .chartStyle(
                    StackedColumnChartStyle(spacing: 2, colors: [.yellow, .orange, .red])
                )
                .background(
                    Color.gray.opacity(0.1)
                        .overlay(
                            GridPattern(horizontalLines: data2.count)
                                .inset(by: 1)
                                .stroke(Color.red.opacity(0.2), style: .init(lineWidth: 1, lineCap: .round))
                        )
                )
                .cornerRadius(16)
                .frame(height: 300)
                .padding()
            
            Chart(data: matrixData1)
                .chartStyle(
                    StackedAreaChartStyle(.quadCurve, colors: [.yellow, .orange, .red])
                )
                .background(
                    Color.gray.opacity(0.1)
                        .overlay(
                            GridPattern(horizontalLines: data2.count)
                                .inset(by: 1)
                                .stroke(Color.red.opacity(0.2), style: .init(lineWidth: 1, lineCap: .round))
                        )
                )
                .cornerRadius(16)
                .frame(height: 300)
                .padding()
            
            ZStack {
                Chart(data: data4)
                    .chartStyle(
                        LineChartStyle(.quadCurve, lineColor: .purple, lineWidth: 3)
                    )
                
                Chart(data: data4)
                    .chartStyle(
                        AreaChartStyle(.quadCurve, fill:
                            LinearGradient(gradient: .init(colors: [Color.purple.opacity(0.8), Color.purple.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                        )
                    )
                
                Chart(data: data5)
                    .chartStyle(
                        ColumnChartStyle(column: Color.white.opacity(0.5), spacing: 2)
                    )
                
                Chart(data: data6)
                    .chartStyle(
                        LineChartStyle(.line, lineColor: Color.white.opacity(0.2), lineWidth: 3)
                    )
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .frame(height: 300)
                .padding()
        }
        .navigationBarTitle("Charts")
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
