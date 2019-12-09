import Foundation
import SwiftUI

extension Color {
    private static let all: [Color] = [.red, .green, .blue, .orange, .yellow, .pink, .purple]
    
    static var random: Color {
        all.randomElement()!
    }
}
