import SwiftUI

struct AnyChartStyle: ChartStyle {
    private let styleMakeBody: (ChartStyle.Configuration) -> AnyView
    
    init<S: ChartStyle>(_ style: S) {
        self.styleMakeBody = style.makeTypeErasedBody
    }
    
    func makeBody(configuration: ChartStyle.Configuration) -> AnyView {
        self.styleMakeBody(configuration)
    }
}

fileprivate extension ChartStyle {
    func makeTypeErasedBody(configuration: ChartStyle.Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
}
