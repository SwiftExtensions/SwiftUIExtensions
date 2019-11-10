import SwiftUI
import Grid

struct BuilderLayoutView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var itemsCount: CGFloat = 8
    @State var minItemWidth: CGFloat = 160
    @State var itemHeight: CGFloat = 160
    @State var hSpacing: CGFloat = 8
    @State var vSpacing: CGFloat = 8
    @State var cornerRadius: CGFloat = 0
    @State var padding: CGFloat = 0
    
    private let itemsCountRange: ClosedRange<CGFloat> = 0...360
    private let minItemWidthRange: ClosedRange<CGFloat> = 8...360
    private let itemHeightRange: ClosedRange<CGFloat> = 8...360
    private let hSpacingRange: ClosedRange<CGFloat> = 0...36
    private let zSpacingRange: ClosedRange<CGFloat> = 0...36
    private let vSpacingRange: ClosedRange<CGFloat> = 0...36
    private var cornerRadiusRange: ClosedRange<CGFloat> = 0...36
    private var paddingRange: ClosedRange<CGFloat> = 0...16
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .bottom)) {
            Grid(0...Int(itemsCount)) { _ in
                Rectangle()
                    .foregroundColor(.random)
                    .cornerRadius(self.cornerRadius)
            }
            .padding(self.padding)
            .gridStyle(
                OLDModularGridStyle(minItemWidth: minItemWidth, itemHeight: itemHeight, hSpacing: hSpacing, vSpacing: vSpacing)
            )
            
            VStack {
                Slider(value: $itemsCount, in: itemsCountRange)
                Slider(value: $minItemWidth, in: minItemWidthRange)
                Slider(value: $itemHeight, in: hSpacingRange)
                Slider(value: $hSpacing, in: zSpacingRange)
                Slider(value: $vSpacing, in: vSpacingRange)
                Slider(value: $cornerRadius, in: 0...min(minItemWidth, itemHeight))
                Slider(value: $padding, in: paddingRange)
                Button("Randomize") {
                    self.randomizeGridValues()
                }
            }
            .padding()
            .background(colorScheme == .light ? Color.white.opacity(0.9) : Color.black.opacity(0.6))
        }
    }
    
    func randomizeGridValues() {
        itemsCount = CGFloat.random(in: itemsCountRange)
        minItemWidth = CGFloat.random(in: minItemWidthRange)
        itemHeight = CGFloat.random(in: itemHeightRange)
        hSpacing = CGFloat.random(in: hSpacingRange)
        vSpacing = CGFloat.random(in: vSpacingRange)
        cornerRadius = CGFloat.random(in: cornerRadiusRange)
        padding = CGFloat.random(in: paddingRange)
    }
}

struct BuilderLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        BuilderLayoutView()
    }
}
