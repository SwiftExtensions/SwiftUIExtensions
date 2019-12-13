import SwiftUI

public typealias XYSlider = PointSlider

public struct PointSlider<V, TrackView: View, ThumbView : View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let x: Binding<V>
    let xBounds: ClosedRange<CGFloat>
    let xStep: CGFloat
    
    let y: Binding<V>
    let yBounds: ClosedRange<CGFloat>
    let yStep: CGFloat
    
    let track: AnyView
    let thumb: AnyView
    let configuration: PointSliderConfiguration
    
    let onEditingChanged: (Bool) -> Void
    
    @State
    private var dragOffset: CGPoint? = nil
    
    public var body: some View {
        let point = CGPoint(x: CGFloat(self.x.wrappedValue), y: CGFloat(self.y.wrappedValue))
        
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                if self.configuration.options.contains(.interactiveTrack) {
                    self.track
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { gestureValue in
                                    let computedValueX = valueFrom(
                                        distance: gestureValue.location.x,
                                        availableDistance: geometry.size.width,
                                        bounds: self.xBounds,
                                        step: self.xStep,
                                        leadingOffset: self.configuration.thumbSize.width / 2,
                                        trailingOffset: self.configuration.thumbSize.width / 2
                                    )
                                    
                                    let computedValueY = self.yBounds.upperBound - valueFrom(
                                        distance: gestureValue.location.y,
                                        availableDistance: geometry.size.height,
                                        bounds: self.yBounds,
                                        step: self.yStep,
                                        leadingOffset: self.configuration.thumbSize.height / 2,
                                        trailingOffset: self.configuration.thumbSize.height / 2
                                    )
                                    
                                    self.x.wrappedValue = V(computedValueX)
                                    self.y.wrappedValue = V(computedValueY)
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
                    self.thumb
                        .frame(width: self.configuration.thumbSize.width, height: self.configuration.thumbSize.height)
                }
                .frame(minWidth: self.configuration.thumbInteractiveSize.width, minHeight: self.configuration.thumbInteractiveSize.height)

                .position(
                    x: distanceFrom(
                        value: point.x,
                        availableDistance: geometry.size.width,
                        bounds: self.xBounds,
                        leadingOffset: self.configuration.thumbSize.width / 2,
                        trailingOffset: self.configuration.thumbSize.width / 2
                    ),
                    y: geometry.size.height - distanceFrom(
                        value: point.y,
                        availableDistance: geometry.size.height,
                        bounds: self.yBounds,
                        leadingOffset: self.configuration.thumbSize.height / 2,
                        trailingOffset: self.configuration.thumbSize.height / 2
                    )
                )
                .gesture(
                    DragGesture()
                        .onChanged { gestureValue in
                            if self.dragOffset == nil {
                                let gragOffsetX = gestureValue.startLocation.x - distanceFrom(
                                    value: point.x,
                                    availableDistance: geometry.size.width,
                                    bounds: self.xBounds,
                                    leadingOffset: self.configuration.thumbSize.width / 2,
                                    trailingOffset: self.configuration.thumbSize.width / 2
                                )
                                
                                let dragOffsetY = gestureValue.startLocation.y - (geometry.size.height - distanceFrom(
                                    value:  point.y,
                                    availableDistance: geometry.size.height,
                                    bounds: self.yBounds,
                                    leadingOffset: self.configuration.thumbSize.height / 2,
                                    trailingOffset: self.configuration.thumbSize.height / 2
                                ))
                                
                                self.dragOffset = CGPoint(x: gragOffsetX, y: dragOffsetY)
                            }
                            
                            let computedValueX = valueFrom(
                                distance: gestureValue.location.x - (self.dragOffset?.x ?? 0),
                                availableDistance: geometry.size.width,
                                bounds: self.xBounds,
                                step: self.xStep,
                                leadingOffset: self.configuration.thumbSize.width / 2,
                                trailingOffset: self.configuration.thumbSize.width / 2
                            )
                            
                            let computedValueY = valueFrom(
                                distance: geometry.size.height - (gestureValue.location.y - (self.dragOffset?.y ?? 0)),
                                availableDistance: geometry.size.height,
                                bounds: self.yBounds,
                                step: self.yStep,
                                leadingOffset: self.configuration.thumbSize.height / 2,
                                trailingOffset: self.configuration.thumbSize.height / 2
                            )
                            
                            self.x.wrappedValue = V(computedValueX)
                            self.y.wrappedValue = V(computedValueY)
                            self.onEditingChanged(true)
                        }
                        .onEnded { _ in
                            self.dragOffset = nil
                            self.onEditingChanged(false)
                        }
                )
            }
        }
        .frame(minWidth: self.configuration.thumbInteractiveSize.width, minHeight: self.configuration.thumbInteractiveSize.height)
    }
}

// MARK: Inits

extension PointSlider {
    public init(x: Binding<V>, xBounds: ClosedRange<V> = 0.0...1.0, xStep: V.Stride = 0.001, y: Binding<V>, yBounds: ClosedRange<V> = 0.0...1.0, yStep: V.Stride = 0.001, track: TrackView, thumb: ThumbView, configuration: PointSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.x = x
        self.xBounds = CGFloat(xBounds.lowerBound)...CGFloat(xBounds.upperBound)
        self.xStep = CGFloat(xStep)
        self.y = y
        self.yBounds = CGFloat(yBounds.lowerBound)...CGFloat(yBounds.upperBound)
        self.yStep = CGFloat(yStep)
        self.track = AnyView(track)
        self.thumb = AnyView(thumb)
        self.configuration = configuration
        self.onEditingChanged = onEditingChanged
    }
}

extension PointSlider where ThumbView == DefaultThumb {
    public init(x: Binding<V>, xBounds: ClosedRange<V> = 0.0...1.0, xStep: V.Stride = 0.001, y: Binding<V>, yBounds: ClosedRange<V> = 0.0...1.0, yStep: V.Stride = 0.001, track: TrackView, configuration: PointSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(x: x, xBounds: xBounds, xStep: xStep, y: y, yBounds: yBounds, yStep: yStep, track: track, thumb: DefaultThumb(), configuration: configuration, onEditingChanged: onEditingChanged)
    }
}

extension PointSlider where TrackView == DefaultPointTrackView {
    public init(x: Binding<V>, xBounds: ClosedRange<V> = 0.0...1.0, xStep: V.Stride = 0.001, y: Binding<V>, yBounds: ClosedRange<V> = 0.0...1.0, yStep: V.Stride = 0.001, thumb: ThumbView, configuration: PointSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(x: x, xBounds: xBounds, xStep: xStep, y: y, yBounds: yBounds, yStep: yStep, track: DefaultPointTrackView(), thumb: thumb, configuration: configuration, onEditingChanged: onEditingChanged)
    }
}

extension PointSlider where TrackView == DefaultPointTrackView, ThumbView == DefaultThumb {
    public init(x: Binding<V>, xBounds: ClosedRange<V> = 0.0...1.0, xStep: V.Stride = 0.001, y: Binding<V>, yBounds: ClosedRange<V> = 0.0...1.0, yStep: V.Stride = 0.001, configuration: PointSliderConfiguration = .defaultConfiguration, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(x: x, xBounds: xBounds, xStep: xStep, y: y, yBounds: yBounds, yStep: yStep, track: DefaultPointTrackView(), thumb: DefaultThumb(), configuration: configuration, onEditingChanged: onEditingChanged)
    }
}

#if DEBUG
struct PointSlider_Previews: PreviewProvider {
    static var previews: some View {
        PointSlider(x: .constant(0.5), y: .constant(0.5), track: Rectangle(), thumb: Circle())
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
#endif
