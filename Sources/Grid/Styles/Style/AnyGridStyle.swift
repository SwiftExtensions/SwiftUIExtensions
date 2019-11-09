import SwiftUI

struct AnyGridStyle: GridStyle {
    private let styleMakeBody: (GridStyle.Configuration) -> AnyView
    
    init<S: GridStyle>(_ style: S) {
        self.styleMakeBody = style.makeTypeErasedBody
    }
    
    func makeBody(configuration: GridStyle.Configuration) -> AnyView {
        self.styleMakeBody(configuration)
    }
}

fileprivate extension GridStyle {
    func makeTypeErasedBody(configuration: GridStyle.Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
}
