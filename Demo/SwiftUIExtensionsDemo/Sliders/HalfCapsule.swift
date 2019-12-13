import Foundation
import SwiftUI

public struct HalfCapsule: View, InsettableShape {
    private let inset: CGFloat

    public func inset(by amount: CGFloat) -> HalfCapsule {
        HalfCapsule(inset: self.inset + amount)
    }
    
    public func path(in rect: CGRect) -> Path {
        let width = rect.size.width - inset * 2
        let height = rect.size.height - inset * 2
        let heightRadius = height / 2
        let widthRadius = width / 2
        let minRadius = min(heightRadius, widthRadius)
        return Path { path in
            path.move(to: CGPoint(x: width, y: 0))
            path.addArc(center: CGPoint(x: minRadius, y: minRadius), radius: minRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 180), clockwise: true)
            path.addArc(center: CGPoint(x: minRadius, y: height - minRadius), radius: minRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 90), clockwise: true)
            path.addLine(to: CGPoint(x: width, y: height))
            path.closeSubpath()
        }.offsetBy(dx: inset, dy: inset)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            self.path(in: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height))
        }
    }
    
    public init(inset: CGFloat = 0) {
        self.inset = inset
    }
}

#if DEBUG

struct CustomKnob_Previews: PreviewProvider {
    static var previews: some View {
        HalfCapsule()
    }
}
#endif
