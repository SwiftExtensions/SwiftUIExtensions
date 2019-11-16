import SwiftUI

struct Card: View {
    let title: String
    let color: Color
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
            Rectangle()
                .foregroundColor(color)
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .opacity(0.5)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.white.opacity(0.3), lineWidth: 4)
        )
        .cornerRadius(16)
    }
}

#if DEBUG
struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(title: "1", color: .red)
    }
}
#endif
