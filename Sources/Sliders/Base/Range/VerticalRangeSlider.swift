import SwiftUI

public typealias VRangeSlider = VerticalRangeSlider

public struct VerticalRangeSlider<V, TrackView: View, LowerThumbView: View, UpperThumbView: View> : View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let range: Binding<ClosedRange<V>>
    let bounds: ClosedRange<CGFloat>
    let step: CGFloat
    
    let track: AnyView
    let lowerThumb: AnyView
    let upperThumb: AnyView
    
    let configuration: RangeSliderConfiguration
    
    let onEditingChanged: (Bool) -> Void
    
    @State
    private var dragOffset: CGFloat? = nil

    public var body: some View {
        let range = CGFloat(self.range.wrappedValue.lowerBound)...CGFloat(self.range.wrappedValue.upperBound)
        
        return GeometryReader { geometry in
            ZStack {
                self.track
                
                ZStack {
                    self.lowerThumb
                        .frame(width: self.configuration.lowerThumbSize.width, height: self.configuration.lowerThumbSize.height)
                }
                .frame(minWidth: self.configuration.lowerThumbInteractiveSize.width, minHeight: self.configuration.lowerThumbInteractiveSize.height)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height - distanceFrom(
                        value: range.lowerBound,
                        availableDistance: geometry.size.height - self.configuration.upperThumbSize.height,
                        bounds: self.bounds,
                        leadingOffset: self.configuration.lowerThumbSize.height / 2,
                        trailingOffset: self.configuration.lowerThumbSize.height / 2
                    )
                )
                .gesture(
                    DragGesture()
                        .onChanged { gestureValue in
                            if self.dragOffset == nil {
                                self.dragOffset = gestureValue.startLocation.y - (geometry.size.height - distanceFrom(
                                    value: range.lowerBound,
                                    availableDistance: geometry.size.height - self.configuration.upperThumbSize.height,
                                    bounds: self.bounds,
                                    leadingOffset: self.configuration.lowerThumbSize.height / 2,
                                    trailingOffset: self.configuration.lowerThumbSize.height / 2
                                ))
                            }
                            
                            let computedLowerBound = valueFrom(
                                distance: geometry.size.height - (gestureValue.location.y - (self.dragOffset ?? 0)),
                                availableDistance: geometry.size.height - self.configuration.upperThumbSize.height,
                                bounds: self.bounds,
                                step: self.step,
                                leadingOffset: self.configuration.lowerThumbSize.height / 2,
                                trailingOffset: self.configuration.lowerThumbSize.height / 2
                            )
                            
                            if self.configuration.options.contains(.forceAdjacentValue) {
                                let computedUpperBound = max(computedLowerBound, CGFloat(self.range.wrappedValue.upperBound))
                                self.range.wrappedValue = V(computedLowerBound)...V(computedUpperBound)
                            } else {
                                let computedLowerBound = min(computedLowerBound, CGFloat(self.range.wrappedValue.upperBound))
                                self.range.wrappedValue = V(computedLowerBound)...V(self.range.wrappedValue.upperBound)
                            }
                            
                            self.onEditingChanged(true)
                        }
                        .onEnded { _ in
                            self.dragOffset = nil
                            self.onEditingChanged(false)
                        }
                )

                ZStack {
                    self.upperThumb
                        .frame(width: self.configuration.upperThumbSize.width, height: self.configuration.upperThumbSize.height)
                }
                .frame(minWidth: self.configuration.upperThumbInteractiveSize.width, minHeight: self.configuration.upperThumbInteractiveSize.height)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height - distanceFrom(
                        value: range.upperBound,
                        availableDistance: geometry.size.height,
                        bounds: self.bounds,
                        leadingOffset: self.configuration.lowerThumbSize.height + self.configuration.upperThumbSize.height / 2,
                        trailingOffset: self.configuration.upperThumbSize.height / 2
                    )
                )
                .gesture(
                    DragGesture()
                        .onChanged { gestureValue in
                            if self.dragOffset == nil {
                                self.dragOffset = gestureValue.startLocation.y - (geometry.size.height - distanceFrom(
                                    value: range.upperBound,
                                    availableDistance: geometry.size.height,
                                    bounds: self.bounds,
                                    leadingOffset: self.configuration.lowerThumbSize.height + self.configuration.upperThumbSize.height / 2,
                                    trailingOffset: self.configuration.upperThumbSize.height / 2
                                ))
                            }
                            
                            let computedUpperBound = valueFrom(
                                distance: geometry.size.height - (gestureValue.location.y - (self.dragOffset ?? 0)),
                                availableDistance: geometry.size.height,
                                bounds: self.bounds,
                                step: self.step,
                                leadingOffset: self.configuration.lowerThumbSize.height + self.configuration.upperThumbSize.height / 2,
                                trailingOffset: self.configuration.upperThumbSize.height / 2
                            )
                            
                            if self.configuration.options.contains(.forceAdjacentValue) {
                                let computedLowerBound = min(computedUpperBound, CGFloat(self.range.wrappedValue.lowerBound))
                                self.range.wrappedValue = V(computedLowerBound)...V(computedUpperBound)
                            } else {
                                let computedUpperBound = max(computedUpperBound, CGFloat(self.range.wrappedValue.lowerBound))
                                self.range.wrappedValue = V(self.range.wrappedValue.lowerBound)...V(computedUpperBound)
                            }
                            
                            self.onEditingChanged(true)
                        }
                        .onEnded { _ in
                            self.dragOffset = nil
                            self.onEditingChanged(false)
                        }
                )
            }
        }
        .frame(minWidth: max(self.configuration.lowerThumbInteractiveSize.width, self.configuration.upperThumbInteractiveSize.width))
    }
}

// MARK: Inits

extension VerticalRangeSlider {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0...1, step: V.Stride = 0.001, track: TrackView, lowerThumb: LowerThumbView, upperThumb: UpperThumbView, configuration: RangeSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.range = range
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.step = CGFloat(step)

        self.track = AnyView(track)
        self.lowerThumb = AnyView(lowerThumb)
        self.upperThumb = AnyView(upperThumb)
        
        self.configuration = configuration

        self.onEditingChanged = onEditingChanged
    }
}

extension VerticalRangeSlider where TrackView == DefaultVerticalRangeTrack<V> {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, lowerThumb: LowerThumbView, upperThumb: UpperThumbView, configuration: RangeSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        
        let track = DefaultVerticalRangeTrack(range: range.wrappedValue, in: bounds, configuration: configuration.verticalTrackConfiguration)
        
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: lowerThumb, upperThumb: upperThumb, configuration: configuration, onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where LowerThumbView == DefaultThumb, UpperThumbView == DefaultThumb {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, track: TrackView, configuration: RangeSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: DefaultThumb(), upperThumb: DefaultThumb(), configuration: configuration, onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where TrackView == DefaultVerticalRangeTrack<V>, LowerThumbView == DefaultThumb, UpperThumbView == DefaultThumb {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, configuration: RangeSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        let track = DefaultVerticalRangeTrack(range: range.wrappedValue, in: bounds, configuration: configuration.verticalTrackConfiguration)
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: DefaultThumb(), upperThumb: DefaultThumb(), configuration: configuration, onEditingChanged: onEditingChanged)
    }
}

// MARK: Inits for same LowerThumbView and UpperThumbView

extension VerticalRangeSlider where LowerThumbView == UpperThumbView {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, track: TrackView, thumb: LowerThumbView, configuration: RangeSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: thumb, upperThumb: thumb, configuration: configuration, onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where TrackView == DefaultVerticalRangeTrack<V>, LowerThumbView == UpperThumbView {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumb: LowerThumbView, configuration: RangeSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        let track = DefaultVerticalRangeTrack(range: range.wrappedValue, in: bounds, configuration: configuration.verticalTrackConfiguration)
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: thumb, upperThumb: thumb, configuration: configuration, onEditingChanged: onEditingChanged)
    }
}

#if DEBUG

struct VerticalRangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        VerticalRangeSlider(range: .constant(0...1))
    }
}

#endif
