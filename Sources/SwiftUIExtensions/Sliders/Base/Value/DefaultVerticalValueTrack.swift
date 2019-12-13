import SwiftUI

public struct DefaultVerticalValueTrack<V>: View where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {
    let value: V
    let bounds: ClosedRange<V>
    let configuration: ValueTrackConfiguration

    public var body: some View {
        VTrack(value: value, in: bounds, configuration: configuration)
            .frame(width: 3)
            .background(Color.secondary.opacity(0.25))
            .cornerRadius(1.5)
    }
    
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, configuration: ValueTrackConfiguration = .defaultConfiguration) {
        self.value = value
        self.bounds = bounds
        self.configuration = configuration
    }
}

#if DEBUG
struct DefaultVerticalValueTrack_Previews: PreviewProvider {
    static var previews: some View {
        DefaultVerticalValueTrack(value: 0.5)
            .previewLayout(.fixed(width: 100, height: 300))
    }
}
#endif
