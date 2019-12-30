import SwiftUI

public struct RegularPolygon: InsettableShape {
    let sides: Int
    let inset: CGFloat
    
    public func inset(by amount: CGFloat) -> RegularPolygon {
        RegularPolygon(sides: self.sides, inset: self.inset + amount)
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: self.sides, in: rect, inset: inset)
    }
    
    public init(sides: Int) {
        self.sides = sides
        self.inset = 0
    }

    public init(sides: Double) {
        self.sides = Int(sides.rounded(.down))
        self.inset = 0
    }
}

extension RegularPolygon {
    init(sides: Int, inset: CGFloat) {
        self.sides = sides
        self.inset = inset
    }
}
