import SwiftUI

public struct AnyGridStyle: GridStyle {
    private let styleMakeBody: (GridStyle.Configuration) -> AnyView
    
    public init<S: GridStyle>(_ style: S) {
        self.styleMakeBody = style.makeTypeErasedBody
    }
    
    public func makeBody(configuration: GridStyle.Configuration) -> AnyView {
        self.styleMakeBody(configuration)
    }
}

fileprivate extension GridStyle {
    func makeTypeErasedBody(configuration: GridStyle.Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
}
