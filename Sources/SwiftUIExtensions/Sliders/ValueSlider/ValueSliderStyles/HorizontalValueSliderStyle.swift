import SwiftUI

public struct HorizontalValueSliderStyle<Track: View>: ValueSliderStyle {
    private let track: (CGFloat) -> Track
    private let thumbSize: CGSize
    private let thumbInteractiveSize: CGSize
    private let options: HorizontalValueSliderOptions

    public func makeBody(configuration: Self.Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                if self.options.contains(.interactiveTrack) {
                    self.track(configuration.value.wrappedValue)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { gestureValue in
                                    let computedValue = valueFrom(
                                        distance: gestureValue.location.x,
                                        availableDistance: geometry.size.width,
                                        bounds: configuration.bounds,
                                        step: configuration.step,
                                        leadingOffset: self.thumbSize.width / 2,
                                        trailingOffset: self.thumbSize.width / 2
                                    )
                                    configuration.value.wrappedValue = computedValue
                                    configuration.onEditingChanged(true)
                                }
                                .onEnded { _ in
                                    configuration.onEditingChanged(false)
                                }
                        )
                } else {
                    self.track(configuration.value.wrappedValue)
                }
                
                ZStack {
                    configuration.thumb
                        .frame(width: self.thumbSize.width, height: self.thumbSize.height)
                }
                .frame(minWidth: self.thumbInteractiveSize.width, minHeight: self.thumbInteractiveSize.height)

                .position(
                    x: distanceFrom(
                        value: configuration.value.wrappedValue,
                        availableDistance: geometry.size.width,
                        bounds: configuration.bounds,
                        leadingOffset: self.thumbSize.width / 2,
                        trailingOffset: self.thumbSize.width / 2
                    ),
                    y: geometry.size.height / 2
                )
                .gesture(
                    DragGesture()
                        .onChanged { gestureValue in
                            if configuration.dragOffset.wrappedValue == nil {
                                configuration.dragOffset.wrappedValue = gestureValue.startLocation.x - distanceFrom(
                                    value: configuration.value.wrappedValue,
                                    availableDistance: geometry.size.width,
                                    bounds: configuration.bounds,
                                    leadingOffset: self.thumbSize.width / 2,
                                    trailingOffset: self.thumbSize.width / 2
                                )
                            }
                            
                            let computedValue = valueFrom(
                                distance: gestureValue.location.x - (configuration.dragOffset.wrappedValue ?? 0),
                                availableDistance: geometry.size.width,
                                bounds: configuration.bounds,
                                step: configuration.step,
                                leadingOffset: self.thumbSize.width / 2,
                                trailingOffset: self.thumbSize.width / 2
                            )
                            
                            configuration.value.wrappedValue = computedValue
                            configuration.onEditingChanged(true)
                        }
                        .onEnded { _ in
                            configuration.dragOffset.wrappedValue = nil
                            configuration.onEditingChanged(false)
                        }
                )
            }
            
        }
        .frame(minHeight: self.thumbInteractiveSize.height)
    }
    
    public init(@ViewBuilder track: @escaping (CGFloat) -> Track, thumbSize: CGSize = CGSize(width: 32, height: 32), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: HorizontalValueSliderOptions = .defaultOptions) {
        self.track = track
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

public struct HorizontalValueSliderOptions: OptionSet {
    public let rawValue: Int

    public static let interactiveTrack = HorizontalValueSliderOptions(rawValue: 1 << 0)
    public static let defaultOptions: HorizontalValueSliderOptions = []
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
