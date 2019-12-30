import SwiftUI

struct AnyValueSliderStyle: ValueSliderStyle {
    private let styleMakeBody: (ValueSliderStyle.Configuration) -> AnyView
    
    init<S: ValueSliderStyle>(_ style: S) {
        self.styleMakeBody = style.makeTypeErasedBody
    }
    
    func makeBody(configuration: ValueSliderStyle.Configuration) -> AnyView {
        self.styleMakeBody(configuration)
    }
}

fileprivate extension ValueSliderStyle {
    func makeTypeErasedBody(configuration: ValueSliderStyle.Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
}
