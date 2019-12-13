import SwiftUI

public struct Decagon: InsettableShape {
    let inset: CGFloat
    
    public func inset(by amount: CGFloat) -> Decagon {
        Decagon(inset: self.inset + amount)
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: 10, in: rect, inset: inset)
    }
    
    public init() {
        inset = 0
    }
}

extension Decagon {
    init(inset: CGFloat) {
        self.inset = inset
    }
}
