import SwiftUI

public typealias VRangeTrack = VerticalRangeTrack

public struct VerticalRangeTrack<V, ValueView: View, MaskView: View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let range: ClosedRange<CGFloat>
    let bounds: ClosedRange<CGFloat>
    let view: AnyView
    let mask: AnyView
    let configuration: RangeTrackConfiguration
    
    public var body: some View {
        GeometryReader { geometry in
            self.view
                .mask(
                    ZStack {
                        self.mask
                             .frame(
                                 height: rangeDistance(
                                    overallLength: geometry.size.height,
                                    range: self.range,
                                    bounds: self.bounds,
                                    lowerStartOffset: self.configuration.lowerLeadingOffset,
                                    lowerEndOffset: self.configuration.lowerTrailingOffset,
                                    upperStartOffset: self.configuration.upperLeadingOffset,
                                    upperEndOffset: self.configuration.upperTrailingOffset
                                 )
                             )
                             .offset(
                                 y: -distanceFrom(
                                    value: self.range.lowerBound,
                                    availableDistance: geometry.size.height,
                                    bounds: self.bounds,
                                    leadingOffset: self.configuration.lowerLeadingOffset,
                                    trailingOffset: self.configuration.lowerTrailingOffset
                                 )
                             )
                    }
                    .frame(height: geometry.size.height, alignment: .bottom)
                )
        }
        .frame(minWidth: 1)
    }
}

extension VerticalRangeTrack {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, view: ValueView, mask: MaskView, configuration: RangeTrackConfiguration = .defaultConfiguration) {
        self.range = CGFloat(range.lowerBound)...CGFloat(range.upperBound)
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.view = AnyView(view)
        self.mask = AnyView(mask)
        self.configuration = configuration
    }
}

extension VerticalRangeTrack where ValueView == DefaultVerticalValueView {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, mask: MaskView, configuration: RangeTrackConfiguration = .defaultConfiguration) {
        self.init(range: range, in: bounds, view: DefaultVerticalValueView(), mask: mask, configuration: configuration)
    }
}

extension VerticalRangeTrack where MaskView == Capsule {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, value: ValueView, configuration: RangeTrackConfiguration = .defaultConfiguration) {
        self.init(range: range, in: bounds, view: value, mask: Capsule(), configuration: configuration)
    }
}

extension VerticalRangeTrack where ValueView == DefaultVerticalValueView, MaskView == Capsule {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, configuration: RangeTrackConfiguration = .defaultConfiguration) {
        self.init(range: range, in: bounds, view: DefaultVerticalValueView(), mask: Capsule(), configuration: configuration)
    }
}
