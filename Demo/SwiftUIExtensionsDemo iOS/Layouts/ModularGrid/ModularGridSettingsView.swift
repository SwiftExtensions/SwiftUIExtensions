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
        NavigationView {
            List {
                Section {
                    Picker(selection: self.$style.axis, label: Text("Axis")) {
                        Text("Vertical")
                            .tag(Axis.vertical)
                        Text("Horizontal")
                            .tag(Axis.horizontal)
                    }
                }
                Section(header: Text("Columns")) {
                    Picker(selection: self.$style.columns, label: Text("Columns")) {
                        Text("Count (\(self.columnsCount))")
                            .tag(Tracks.count(self.columnsCount))
                        Text("Fixed (\(Int(self.columnsFixed)))")
                            .tag(Tracks.fixed(self.columnsFixed))
                        Text("Min (\(Int(self.columnsMin)))")
                            .tag(Tracks.min(self.columnsMin))
                    }
                }
                
                Section(header: Text("Rows")) {
                    Picker(selection: self.$style.rows, label: Text("Rows")) {
                        Text("Count (\(self.rowsCount))")
                            .tag(Tracks.count(self.rowsCount))
                        Text("Fixed (\(Int(self.rowsFixed)))")
                            .tag(Tracks.fixed(self.rowsFixed))
                        Text("Min (\(Int(self.rowsMin)))")
                            .tag(Tracks.min(self.rowsMin))
                    }
                }
                
                Section(header: Text("Spacing (\(Int(self.style.spacing)))")) {
                    Slider(value: self.$style.spacing, in: 0...32)
                }
            }
            .navigationBarTitle("Modular Style")
            .navigationBarItems(trailing:
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                }
            )
        }
        .navigationViewStyle(
            StackNavigationViewStyle()
        )
        .pickerStyle(
            SegmentedPickerStyle()
        )
        .listStyle(
            GroupedListStyle()
        )
    }
}

struct ModularGridSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ModularGridSettingsView(style: .constant(ModularGridStyle(columns: 3, rows: 3)))
    }
}
