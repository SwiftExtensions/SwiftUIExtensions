import SwiftUI

struct AreaChart: Shape {
    private let lineType: LineType
    private let unitPoints: [UnitPoint]
    private let bottomUnitPoints: [UnitPoint]?

    public func path(in rect: CGRect) -> Path {
        Path { path in
            switch self.lineType {
            case .line:
                path.addLines(self.unitPoints.points(in: rect))
            case .quadCurve:
                path.addQuadCurves(self.unitPoints.points(in: rect))
            }
        
            if let bottomUnitPoints = bottomUnitPoints {
                switch self.lineType {
                case .line:
                    bottomUnitPoints.reversed().forEach {
                        path.addLine(to: CGPoint(unitPoint: $0, in: rect))
                    }
                case .quadCurve:
                    path.addQuadCurves(bottomUnitPoints.reversed().points(in: rect))
                }
            } else {
                path.addLine(to: CGPoint(unitPoint: .topTrailing, in: rect))
                path.addLine(to: CGPoint(unitPoint: .topLeading, in: rect))
            }
            path.closeSubpath()
        }
    }
    
    init<Data: RandomAccessCollection>(unitData: Data, bottomUnitData: Data? = nil, lineType: LineType) where Data.Element : BinaryFloatingPoint {
        self.lineType = lineType
        let step: CGFloat = unitData.count > 1 ? 1.0 / CGFloat(unitData.count - 1) : 1.0
        self.unitPoints = unitData.enumerated().map { (index, dataPoint) in UnitPoint(x: step * CGFloat(index), y: CGFloat(dataPoint)) }
        self.bottomUnitPoints = bottomUnitData?.enumerated().map { (index, dataPoint) in UnitPoint(x: step * CGFloat(index), y: CGFloat(dataPoint)) }
    }
}
