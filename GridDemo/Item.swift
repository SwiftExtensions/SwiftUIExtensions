import SwiftUI

struct Item: Identifiable {
    let number: Int
    let id: UUID = UUID()
    let color: Color = .random
}
