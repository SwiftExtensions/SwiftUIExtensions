import SwiftUI

public struct ValueSlider<Track>: View where Track: View {
    @Environment(\.valueSliderStyle) private var style
    @State private var dragOffset: CGFloat?
    
    private var configuration: ValueSliderStyleConfiguration
    
    public var body: some View {
        self.style.makeBody(configuration:
            self.configuration.with(dragOffset: self.$dragOffset)
        )
    }
}

extension ValueSlider {
    init(_ configuration: ValueSliderStyleConfiguration) {
        self.configuration = configuration
    }
}

extension ValueSlider where Track == ValueSliderStyleConfiguration.Track {
    public init<V>(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        
        self.init(
            ValueSliderStyleConfiguration(
                value: Binding(get: { CGFloat(value.wrappedValue) }, set: { value.wrappedValue = V($0) }),
                bounds: CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound),
                step: CGFloat(step),
                onEditingChanged: onEditingChanged,
                dragOffset: .constant(0),
                track: .init(view: DefaultHorizontalValueTrack(value: CGFloat(value.wrappedValue))),
                thumb: .init(view: DefaultThumb())
            )
        )
    }
}

extension ValueSlider {
    public init<V>(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, track: Track, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        
        self.init(
            ValueSliderStyleConfiguration(
                value: Binding(get: { CGFloat(value.wrappedValue) }, set: { value.wrappedValue = V($0) }),
                bounds: CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound),
                step: CGFloat(step),
                onEditingChanged: onEditingChanged,
                dragOffset: .constant(0),
                track: .init(view: track),
                thumb: .init(view: DefaultThumb())
            )
        )
    }
}

struct ValueSlider_Previews: PreviewProvider {
    static var previews: some View {
        ValueSlider(value: .constant(0.3))
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
