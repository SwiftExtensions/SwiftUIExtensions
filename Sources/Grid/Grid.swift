import SwiftUI

/// A view that arranges its children in a grid.
public struct Grid<Content>: View where Content: View {
    @Environment(\.gridStyle) private var style
    let items: [GridItem]
    
    public var body: some View {
        self.style.makeBody(configuration: GridStyleConfiguration(items: items))
    }
}
