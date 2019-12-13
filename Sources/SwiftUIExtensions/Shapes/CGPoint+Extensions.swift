import SwiftUI

public extension CGPoint {
    init(unitPoint: UnitPoint, in rect: CGRect) {
        self.init(
            x: rect.width * unitPoint.x,
            y: rect.height - (rect.height * unitPoint.y)
        )
    }
}

public extension CGPoint {
    func halfway(to point: CGPoint) -> CGPoint {
        CGPoint(x: (self.x + point.x) * 0.5, y: (self.y + point.y) * 0.5)
    }
    
    func quadCurveControlPoint(with point: CGPoint) -> CGPoint {
        let halfwayPoint = self.halfway(to: point)
        let absoluteDistance = abs(point.y - halfwayPoint.y)
        
        if self.y < point.y {
            return CGPoint(x: halfwayPoint.x, y: halfwayPoint.y + absoluteDistance)
        } else if self.y > point.y {
            return CGPoint(x: halfwayPoint.x, y: halfwayPoint.y - absoluteDistance)
        } else {
            return halfwayPoint
        }
    }
}

public extension Collection where Element == UnitPoint {
    func points(in rect: CGRect) -> [CGPoint] {
        self.map { CGPoint(unitPoint: $0, in: rect) }
    }
}
