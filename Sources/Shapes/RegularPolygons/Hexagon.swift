import SwiftUI

public struct Hexagon: InsettableShape {
    let inset: CGFloat
    
    public func inset(by amount: CGFloat) -> Hexagon {
        Hexagon(inset: self.inset + amount)
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: 6, in: rect, inset: inset)
    }
    
    public init() {
        inset = 0
    }
}

extension Hexagon {
    init(inset: CGFloat) {
        self.inset = inset
    }
}
