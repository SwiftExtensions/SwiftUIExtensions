import SwiftUI

public struct Heptagon: InsettableShape {
    let inset: CGFloat
    
    public func inset(by amount: CGFloat) -> Heptagon {
        Heptagon(inset: self.inset + amount)
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: 7, in: rect, inset: inset)
    }
    
    public init() {
        inset = 0
    }
}

extension Heptagon {
    init(inset: CGFloat) {
        self.inset = inset
    }
}
