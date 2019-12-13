import SwiftUI

public typealias VSlider = VerticalValueSlider

public struct VerticalValueSlider<V, TrackView: View, ThumbView : View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let value: Binding<V>
    let bounds: ClosedRange<CGFloat>
    let step: CGFloat
    let track: AnyView
    let thumbView: AnyView
    let configuration: ValueSliderConfiguration
    
    let onEditingChanged: (Bool) -> Void
    
    @State
    private var dragOffset: CGFloat? = nil
    
    public var body: some View {
        let value = CGFloat(self.value.wrappedValue)
        
        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                if self.configuration.options.contains(.interactiveTrack) {
                    self.track
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { gestureValue in
                                    let computedValue = self.bounds.upperBound - valueFrom(
                                        distance: gestureValue.location.y,
                                        availableDistance: geometry.size.height,
                                        bounds: self.bounds,
                                        step: self.step,
                                        leadingOffset: self.configuration.thumbSize.height / 2,
                                        trailingOffset: self.configuration.thumbSize.height / 2
                                    )
                                    self.value.wrappedValue = V(computedValue)
                                    self.onEditingChanged(true)
                                }
                                .onEnded { _ in
                                    self.onEditingChanged(false)
                                }
                        )
                } else {
                    self.track
                }

                ZStack {
                    self.thumbView
                        .frame(width: self.configuration.thumbSize.width, height: self.configuration.thumbSize.height)
                }
                .frame(minWidth: self.configuration.thumbInteractiveSize.width, minHeight: self.configuration.thumbInteractiveSize.height)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height - distanceFrom(
                        value: value,
                        availableDistance: geometry.size.height,
                        bounds: self.bounds,
                        leadingOffset: self.configuration.thumbSize.height / 2,
                        trailingOffset: self.configuration.thumbSize.height / 2
                    )
                )
                .gesture(
                    DragGesture()
                        .onChanged { gestureValue in
                            if self.dragOffset == nil {
                                self.dragOffset = gestureValue.startLocation.y - (geometry.size.height - distanceFrom(
                                    value: value,
                                    availableDistance: geometry.size.height,
                                    bounds: self.bounds,
                                    leadingOffset: self.configuration.thumbSize.height / 2,
                                    trailingOffset: self.configuration.thumbSize.height / 2
                                ))
                            }
                            
                            let computedValue = valueFrom(
                                distance: geometry.size.height - (gestureValue.location.y - (self.dragOffset ?? 0)),
                                availableDistance: geometry.size.height,
                                bounds: self.bounds,
                                step: self.step,
                                leadingOffset: self.configuration.thumbSize.height / 2,
                                trailingOffset: self.configuration.thumbSize.height / 2
                            )
                            
                            self.value.wrappedValue = V(computedValue)
                            self.onEditingChanged(true)
                        }
                        .onEnded { _ in
                            self.dragOffset = nil
                            self.onEditingChanged(false)
                        }
                )
            }
        }
        .frame(minWidth: self.configuration.thumbInteractiveSize.width)
    }
}

// MARK: Inits

extension VerticalValueSlider {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, track: TrackView, thumb: ThumbView, configuration: ValueSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.value = value
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.step = CGFloat(step)
        self.track = AnyView(track)
        self.thumbView = AnyView(thumb)
        self.configuration = configuration
        self.onEditingChanged = onEditingChanged
    }
}

extension VerticalValueSlider where TrackView == DefaultVerticalValueTrack<V>, ThumbView == DefaultThumb {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, configuration: ValueSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        let track = DefaultVerticalValueTrack(value: value.wrappedValue, in: bounds, configuration: configuration.verticalTrackConfiguration)
        self.init(value: value, in: bounds, step: step, track: track, thumb: DefaultThumb(), configuration: configuration, onEditingChanged: onEditingChanged)
    }
}

extension VerticalValueSlider where TrackView == DefaultVerticalValueTrack<V> {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumb: ThumbView, configuration: ValueSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        let track = DefaultVerticalValueTrack(value: value.wrappedValue, in: bounds, configuration: configuration.verticalTrackConfiguration)
        self.init(value: value, in: bounds, step: step, track: track, thumb: thumb, configuration: configuration, onEditingChanged: onEditingChanged)
    }
}

extension VerticalValueSlider where ThumbView == DefaultThumb {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, track: TrackView, configuration: ValueSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, track: track, thumb: DefaultThumb(), configuration: configuration, onEditingChanged: onEditingChanged)
    }
}

#if DEBUG
struct VerticalValueSlider_Previews: PreviewProvider {
    static var previews: some View {
        VerticalValueSlider(value: .constant(0.5))
            .previewLayout(.fixed(width: 100, height: 300))
    }
}
#endif
