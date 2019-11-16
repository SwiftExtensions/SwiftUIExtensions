import SwiftUI

extension Grid {
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.id = id
        self.content = content
    }
}

extension Grid where ID == Data.Element.ID, Data.Element : Identifiable {
    public init(_ data: Data, content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.id = \Data.Element.id
        self.content = content
    }
}

extension Grid where Data == ClosedRange<Int>, ID == Int {
    public init(_ data: Data, content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.id = \Data.Element.self
        self.content = content
    }
}

//extension Grid {
//    public init<C0: View>(@ViewBuilder content: () -> C0) {
//        self.items = [AnyView(content())]
//    }
//
//    public init<C0: View, C1: View>(@ViewBuilder content: () -> TupleView<(C0, C1)>) {
//        self.items = [AnyView(content().value.0), AnyView(content().value.1)]
//    }
//
//    public init<C0: View, C1: View, C2: View>(@ViewBuilder content: () -> TupleView<(C0, C1, C2)>) {
//        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2)]
//    }
//
//    public init<C0: View, C1: View, C2: View, C3: View>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3)>) {
//        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3)]
//    }
//
//    public init<C0: View, C1: View, C2: View, C3: View, C4: View>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3, C4)>) {
//        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3), AnyView(content().value.4)]
//    }
//
//    public init<C0: View, C1: View, C2: View, C3: View, C4: View, C5: View>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3, C4, C5)>) {
//        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3), AnyView(content().value.4), AnyView(content().value.5)]
//    }
//
//    public init<C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3, C4, C5, C6)>) {
//        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3), AnyView(content().value.4), AnyView(content().value.5), AnyView(content().value.6)]
//    }
//
//    public init<C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8)>) {
//        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3), AnyView(content().value.4), AnyView(content().value.5), AnyView(content().value.6), AnyView(content().value.7), AnyView(content().value.8)]
//    }
//
//    public init<C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View, C9: View>(@ViewBuilder content: () -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)>) {
//        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3), AnyView(content().value.4), AnyView(content().value.5), AnyView(content().value.6), AnyView(content().value.7), AnyView(content().value.8), AnyView(content().value.9)]
//    }
//}
