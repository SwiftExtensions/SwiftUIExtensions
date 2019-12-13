import SwiftUI

public struct Nonagon: InsettableShape {
    let inset: CGFloat
    
    public func inset(by amount: CGFloat) -> Nonagon {
        Nonagon(inset: self.inset + amount)
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: 9, in: rect, inset: inset)
    }
    
    public init() {
        inset = 0
    }
}

extension Nonagon {
    init(inset: CGFloat) {
        self.inset = inset
    }
}
