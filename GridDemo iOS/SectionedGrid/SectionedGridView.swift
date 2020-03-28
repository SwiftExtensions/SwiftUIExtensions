import SwiftUI
import Grid

struct SectionedGridView: View {
    var body: some View {
        ScrollView {
            ForEach(1..<8) { section in
                Section {
                    HStack {
                        Text("Section \(section)").font(.headline).fontWeight(.bold)
                        Spacer()
                    }
                    
                    Grid(self.rangeFor(section: section), id: \.self) { index in
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(
                                Image("\(index)")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFill()
                            )
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    
                    Spacer(minLength: 16)
                }
            }

            .padding(8)
        }
        .navigationBarTitle("Sectioned Grid", displayMode: .inline)
        .gridStyle(
            ModularGridStyle(columns: .min(80), rows: .fixed(80), spacing: 4)
        )
    }
    
    private func rangeFor(section: Int) -> Range<Int> {
        switch section {
        case 1: return Range(1...10)
        case 2: return Range(11...15)
        case 3: return Range(16...26)
        case 4: return Range(27...35)
        case 5: return Range(36...38)
        case 6: return Range(39...55)
        case 7: return Range(56...69)
        default:
            fatalError()
        }
    }
}

struct SectionedGridView_Previews: PreviewProvider {
    static var previews: some View {
        SectionedGridView()
    }
}
