import SwiftUI
import SwiftUIExtensions

struct LinesView: View {
    var body: some View {
        ScrollView {
            Line(unitPoints: [
                UnitPoint(x: 0.0, y: 0.1),
                UnitPoint(x: 0.5, y: 0.9),
                UnitPoint(x: 1.0, y: 0.1)
            ])
            .stroke(Color.red, style: .init(lineWidth: 4, lineCap: .round))
            .frame(height: 200)
            .padding()
            
            QuadCurve(unitData: [
                0.1, 0.9, 0.1
            ])
            .stroke(Color.blue, style: .init(lineWidth: 2, lineCap: .round))
            .frame(height: 200)
            .padding()
        }
        .navigationBarTitle("Lines")
    }
}

struct LinesView_Previews: PreviewProvider {
    static var previews: some View {
        LinesView()
    }
}
