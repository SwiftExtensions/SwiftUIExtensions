import SwiftUI

public typealias HTrack = HorizontalValueTrack

public struct HorizontalValueTrack<V, ValueView: View, MaskView: View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let value: CGFloat
    let bounds: ClosedRange<CGFloat>
    let view: AnyView
    let mask: AnyView
    let configuration: ValueTrackConfiguration
    
    public var body: some View {
        GeometryReader { geometry in
            self.view
                .mask(
                    ZStack {
                        self.mask
                            .frame(
                                width: distanceFrom(
                                    value: self.value,
                                    availableDistance: geometry.size.width,
                                    bounds: self.bounds,
                                    leadingOffset: self.configuration.leadingOffset,
                                    trailingOffset: self.configuration.trailingOffset
                                )
                            )
                    }
                    .frame(width: geometry.size.width, alignment: .leading)
                )
        }
    }
}

extension HorizontalValueTrack {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, view: ValueView, mask: MaskView, configuration: ValueTrackConfiguration = .defaultConfiguration) {
        self.value = CGFloat(value)
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.view = AnyView(view)
        self.mask = AnyView(mask)
        self.configuration = configuration
    }
}

extension HorizontalValueTrack where ValueView == DefaultHorizontalValueView {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, mask: MaskView, configuration: ValueTrackConfiguration = .defaultConfiguration) {
        self.init(value: value, in: bounds, view: DefaultHorizontalValueView(), mask: mask, configuration: configuration)
    }
}

extension HorizontalValueTrack where MaskView == Capsule {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, view: ValueView, configuration: ValueTrackConfiguration = .defaultConfiguration) {
        self.init(value: value, in: bounds, view: view, mask: Capsule(), configuration: configuration)
    }
}

extension HorizontalValueTrack where ValueView == DefaultHorizontalValueView, MaskView == Capsule {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, configuration: ValueTrackConfiguration = .defaultConfiguration) {
        self.init(value: value, in: bounds, view: DefaultHorizontalValueView(), mask: Capsule(), configuration: configuration)
    }
}
