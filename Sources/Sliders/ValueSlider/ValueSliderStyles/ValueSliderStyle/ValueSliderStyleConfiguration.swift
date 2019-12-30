import SwiftUI

public struct ValueSliderStyleConfiguration {
    public let value: Binding<CGFloat>
    public let bounds: ClosedRange<CGFloat>
    public let step: CGFloat
    public let onEditingChanged: (Bool) -> Void
    public var dragOffset: Binding<CGFloat?>
    public let track: ValueSliderStyleConfiguration.Track
    public let thumb: ValueSliderStyleConfiguration.Thumb
    
    func with(dragOffset: Binding<CGFloat?>) -> Self {
        var mutSelf = self
        mutSelf.dragOffset = dragOffset
        return mutSelf
    }
}

public extension ValueSliderStyleConfiguration {
    struct Track: View {
        let typeErasedTrack: AnyView
        
        init<T: View>(view: T) {
            self.typeErasedTrack = AnyView(view)
        }
        
        public var body: some View {
            self.typeErasedTrack
        }
    }
}

public extension ValueSliderStyleConfiguration {
    struct Thumb: View {
        let typeErasedThumb: AnyView
        
        init<T: View>(view: T) {
            self.typeErasedThumb = AnyView(view)
        }
        
        public var body: some View {
            self.typeErasedThumb
        }
    }
}
