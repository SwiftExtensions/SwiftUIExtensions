import SwiftUI

public struct Octagon: InsettableShape {
    let inset: CGFloat
    
    public func inset(by amount: CGFloat) -> Octagon {
        Octagon(inset: self.inset + amount)
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: 8, in: rect, inset: inset)
    }
    
    public init() {
        inset = 0
    }
}

extension Octagon {
    init(inset: CGFloat) {
        self.inset = inset
    }
}
