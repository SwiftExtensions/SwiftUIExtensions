import SwiftUI

public struct Line: Shape {
    private let unitPoints: [UnitPoint]

    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.addLines(self.unitPoints.points(in: rect))
        }
    }
    
    public init(unitPoints: [UnitPoint]) {
        self.unitPoints = unitPoints
    }
}

public extension Line {
    init<Data: RandomAccessCollection>(unitData: Data) where Data.Element : BinaryFloatingPoint {
        let step: CGFloat = unitData.count > 1 ? 1.0 / CGFloat(unitData.count - 1) : 1.0
        self.unitPoints = unitData.enumerated().map { (index, dataPoint) in UnitPoint(x: step * CGFloat(index), y: CGFloat(dataPoint)) }
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Line(unitPoints: [
            UnitPoint(x: 0.1, y: 0.1),
            UnitPoint(x: 0.5, y: 0.9),
            UnitPoint(x: 0.9, y: 0.1)
        ])
            .stroke(Color.red, style: .init(lineWidth: 4, lineCap: .round))
            .background(Color.black)
            .drawingGroup()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
