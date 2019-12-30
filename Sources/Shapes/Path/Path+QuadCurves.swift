import SwiftUI


public extension Path {
    mutating func addQuadCurves(_ points: [CGPoint]) {
        guard points.count > 0 else { return }
        
        if let currentPoint = self.currentPoint {
            var lastPoint = currentPoint
            
            (0..<points.count).forEach { index in
                let nextPoint = points[index]
                
                let halfwayPoint = lastPoint.halfway(to: nextPoint)
    
                let firstControlPoint = halfwayPoint.quadCurveControlPoint(with: lastPoint)
                self.addQuadCurve(to: halfwayPoint, control: firstControlPoint)
                
                let secondControlPoint = halfwayPoint.quadCurveControlPoint(with: nextPoint)
                self.addQuadCurve(to: nextPoint, control: secondControlPoint)
                
                lastPoint = nextPoint
            }
        } else {
            var lastPoint = points[0]
            self.move(to: lastPoint)
            
            (1..<points.count).forEach { index in
                let nextPoint = points[index]
                
                let halfwayPoint = lastPoint.halfway(to: nextPoint)
    
                let firstControlPoint = halfwayPoint.quadCurveControlPoint(with: lastPoint)
                self.addQuadCurve(to: halfwayPoint, control: firstControlPoint)
                
                let secondControlPoint = halfwayPoint.quadCurveControlPoint(with: nextPoint)
                self.addQuadCurve(to: nextPoint, control: secondControlPoint)
                
                lastPoint = nextPoint
            }
        }
    }
}
