import SwiftUI

public struct GridStyleConfiguration {
    let items: [AnyView]
    var alignmentGuides: Binding<[Int: CGPoint]>?
}

extension GridStyleConfiguration {
    func with(alignmentGuides: Binding<[Int: CGPoint]>) -> Self {
        var mutSelf = self
        mutSelf.alignmentGuides = alignmentGuides
        return mutSelf
    }
}
