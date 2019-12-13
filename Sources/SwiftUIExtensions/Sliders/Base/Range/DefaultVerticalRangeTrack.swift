import SwiftUI

public struct DefaultVerticalRangeTrack<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let range: ClosedRange<V>
    let bounds: ClosedRange<V>
    var configuration: RangeTrackConfiguration
    
    public var body: some View {
        VRangeTrack(
            range: range,
            in: bounds,
            configuration: configuration
        )
        .frame(width: 3)
        .background(Color.secondary.opacity(0.25))
        .cornerRadius(1.5)
    }
    
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, configuration: RangeTrackConfiguration = .defaultConfiguration) {
        self.range = range
        self.bounds = bounds
        self.configuration = configuration
    }
}

#if DEBUG
struct DefaultVerticalRangeTrack_Previews: PreviewProvider {
    static var previews: some View {
        DefaultVerticalRangeTrack(range: 0.2...0.8)
            .previewLayout(.fixed(width: 100, height: 300))
    }
}
#endif
