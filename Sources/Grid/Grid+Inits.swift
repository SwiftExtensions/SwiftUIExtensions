import SwiftUI

extension Grid {
    public init<Data, Item>(_ data: Data, @ViewBuilder item: @escaping (Data.Element) -> Item) where Content == ForEach<Data, Data.Element.ID, Item>, Data : RandomAccessCollection, Item : View, Data.Element : Identifiable {
        self.items = data.map({ AnyView(item($0)) })
    }

    public init<Data, ID, Item>(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder item: @escaping (Data.Element) -> Item) where Content == ForEach<Data, ID, Item>, Data : RandomAccessCollection, ID : Hashable, Item : View {
        self.items = data.map({ AnyView(item($0)) })
    }

    public init<Item>(_ data: Range<Int>, @ViewBuilder item: @escaping (Int) -> Item) where Content == ForEach<Range<Int>, Int, Item>, Item : View {
        self.items = data.map({ AnyView(item($0)) })
    }
}

extension Grid {
    public init<C0: View, C1: View>(@ViewBuilder content: () -> Content) where Content == TupleView<(C0, C1)> {
        self.items = [AnyView(content().value.0), AnyView(content().value.1)]
    }
    
    public init<C0: View, C1: View, C2: View>(@ViewBuilder content: () -> Content) where Content == TupleView<(C0, C1, C2)> {
        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2)]
    }
    
    public init<C0: View, C1: View, C2: View, C3: View>(@ViewBuilder content: () -> Content) where Content == TupleView<(C0, C1, C2, C3)> {
        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3)]
    }

    public init<C0: View, C1: View, C2: View, C3: View, C4: View>(@ViewBuilder content: () -> Content) where Content == TupleView<(C0, C1, C2, C3, C4)> {
        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3), AnyView(content().value.4)]
    }
    
    public init<C0: View, C1: View, C2: View, C3: View, C4: View, C5: View>(@ViewBuilder content: () -> Content) where Content == TupleView<(C0, C1, C2, C3, C4, C5)> {
        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3), AnyView(content().value.4), AnyView(content().value.5)]
    }
    
    public init<C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View>(@ViewBuilder content: () -> Content) where Content == TupleView<(C0, C1, C2, C3, C4, C5, C6)> {
        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3), AnyView(content().value.4), AnyView(content().value.5), AnyView(content().value.6)]
    }
    
    public init<C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View>(@ViewBuilder content: () -> Content) where Content == TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8)> {
        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3), AnyView(content().value.4), AnyView(content().value.5), AnyView(content().value.6), AnyView(content().value.7), AnyView(content().value.8)]
    }
    
    public init<C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View, C9: View>(@ViewBuilder content: () -> Content) where Content == TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)> {
        self.items = [AnyView(content().value.0), AnyView(content().value.1), AnyView(content().value.2), AnyView(content().value.3), AnyView(content().value.4), AnyView(content().value.5), AnyView(content().value.6), AnyView(content().value.7), AnyView(content().value.8), AnyView(content().value.9)]
    }
}
