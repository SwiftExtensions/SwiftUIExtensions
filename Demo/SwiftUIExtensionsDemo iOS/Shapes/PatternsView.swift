import SwiftUI
import SwiftUIExtensions

struct PatternsView: View {
    var body: some View {
        ScrollView {
            GridPattern(horizontalLines: 20, verticalLines: 40)
                .stroke(Color.white.opacity(0.3), style: .init(lineWidth: 1, lineCap: .round))
                .frame(height: 200)
                .background(Color.blue)
                .padding()
            
            
            LinearGradient(gradient: Gradient(colors: [.orange, .red, .blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(height: 200)
                .clipShape(
                    GridPattern(horizontalLines: 25, verticalLines: 25).inset(by: 1).stroke(lineWidth: 1)
                )
                .padding()
            
            LinearGradient(gradient: Gradient(colors: [.purple, .red, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(height: 200)
                .clipShape(
                    GridPattern(horizontalLines: 10)
                        .inset(by: 2)
                        .stroke(style: .init(lineWidth: 4, lineCap: .round, lineJoin: .round, miterLimit: 2, dash: [10], dashPhase: 0))
                )
                .padding()
            
        }
        .navigationBarTitle("Patterns")
    }
}

struct PatternsView_Previews: PreviewProvider {
    static var previews: some View {
        PatternsView()
    }
}
