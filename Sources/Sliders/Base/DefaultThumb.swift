import SwiftUI

public struct DefaultThumb: View {
    public var body: some View {
        Capsule()
            .foregroundColor(.white)
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1.5)
    }
}

public extension CGSize {
    static let defaultThumbSize: CGSize = CGSize(width: 27, height: 27)
    static let defaultThumbInteractiveSize : CGSize = CGSize(width: 44, height: 44)
}

struct DefaultThumb_Previews: PreviewProvider {
    static var previews: some View {
        DefaultThumb()
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
