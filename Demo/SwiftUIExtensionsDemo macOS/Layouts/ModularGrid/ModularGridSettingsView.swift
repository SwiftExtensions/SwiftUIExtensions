import SwiftUI
import SwiftUIExtensions

struct ModularGridSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var style: ModularGridStyle
    
    @State var columnsCount: Int = 3
    @State var columnsFixed: CGFloat = 150
    @State var columnsMin: CGFloat = 100.0
    
    @State var rowsCount: Int = 3
    @State var rowsFixed: CGFloat = 150
    @State var rowsMin: CGFloat = 100.0
    
    var body: some View {
        VStack(spacing: 16) {
            Picker(selection: self.$style.axis, label: Text("Axis")) {
                Text("Vertical")
                    .tag(Axis.vertical)
                Text("Horizontal")
                    .tag(Axis.horizontal)
            }

            Picker(selection: self.$style.columns, label: Text("Columns")) {
                Text("Count (\(self.columnsCount))")
                    .tag(Tracks.count(self.columnsCount))
                Text("Fixed (\(Int(self.columnsFixed)))")
                    .tag(Tracks.fixed(self.columnsFixed))
                Text("Min (\(Int(self.columnsMin)))")
                    .tag(Tracks.min(self.columnsMin))
            }
            
            Picker(selection: self.$style.rows, label: Text("Rows")) {
                Text("Count (\(self.rowsCount))")
                    .tag(Tracks.count(self.rowsCount))
                Text("Fixed (\(Int(self.rowsFixed)))")
                    .tag(Tracks.fixed(self.rowsFixed))
                Text("Min (\(Int(self.rowsMin)))")
                    .tag(Tracks.min(self.rowsMin))
            }
            
            HStack {
                Text("Spacing (\(Int(self.style.spacing)))")
                Slider(value: self.$style.spacing, in: 0...32)
            }
            
            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                Text("Close")
            }
        }
        .padding()
        .pickerStyle(
            SegmentedPickerStyle()
        )
    }
}

struct ModularGridSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridSettingsView(style: .constant(ModularGridStyle(columns: 3, rows: 3)))
    }
}
