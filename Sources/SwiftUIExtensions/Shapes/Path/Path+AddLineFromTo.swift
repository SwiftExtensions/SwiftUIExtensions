import SwiftUI

public extension Path {
    mutating func addLine(from p1: CGPoint, to p2: CGPoint) {
        self.move(to: p1)
        self.addLine(to: p2)
    }
}
