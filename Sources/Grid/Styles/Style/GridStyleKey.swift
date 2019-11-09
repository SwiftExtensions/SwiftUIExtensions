import SwiftUI

struct GridStyleKey: EnvironmentKey {
    static let defaultValue: AnyGridStyle = AnyGridStyle(AutoColumnsGridStyle())
}
