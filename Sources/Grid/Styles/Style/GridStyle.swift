import SwiftUI

public protocol GridStyle {
    associatedtype Body : View
    typealias Configuration = GridStyleConfiguration
    func makeBody(configuration: Self.Configuration) -> Self.Body
}
