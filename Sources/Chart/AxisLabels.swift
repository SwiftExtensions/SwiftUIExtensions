import SwiftUI

public struct AxisLabels<Content: View>: View {
    let axis: Axis
    let labels: [AnyView]
    
    public var body: some View {
        GeometryReader { geometry in
            if self.axis == .horizontal {
                HStack(spacing: 0) {
                    ForEach(0..<self.labels.count, id: \.self) { index in
                        self.labels[index].frame(width: geometry.size.width / CGFloat(self.labels.count), alignment: .center)
                    }
                }
            } else {
                VStack(spacing: 0) {
                    ForEach(0..<self.labels.count, id: \.self) { index in
                        self.labels[index].frame(height: geometry.size.height / CGFloat(self.labels.count), alignment: .center)
                    }
                }
            }
        }
    }
    
    public init<Data, Label>(_ axis: Axis = .horizontal, data: Data, @ViewBuilder label: @escaping (Data.Element) -> Label) where Content == ForEach<Data, Data.Element.ID, Label>, Data : RandomAccessCollection, Label : View, Data.Element : Identifiable {
        self.axis = axis
        self.labels = data.map({ AnyView(label($0)) })
    }

    public init<Data, ID, Label>(_ axis: Axis = .horizontal, data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder label: @escaping (Data.Element) -> Label) where Content == ForEach<Data, ID, Label>, Data : RandomAccessCollection, ID : Hashable, Label : View {
        self.axis = axis
        self.labels = data.map({ AnyView(label($0)) })
    }

    public init<Label>(_ axis: Axis = .horizontal, data: Range<Int>, @ViewBuilder label: @escaping (Int) -> Label) where Content == ForEach<Range<Int>, Int, Label>, Label : View {
        self.axis = axis
        self.labels = data.map({ AnyView(label($0)) })
    }
}
