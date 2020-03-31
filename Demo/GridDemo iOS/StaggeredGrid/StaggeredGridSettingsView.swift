import SwiftUI
import Grid

struct StaggeredGridSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var style: StaggeredGridStyle
    
    @State var tracksCount: Int = 3
    @State var tracksFixed: CGFloat = 150
    @State var tracksMin: CGFloat = 100.0
    
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
                Section(header: Text("Tracks")) {
                    Picker(selection: self.$style.tracks, label: Text("Tracks")) {
                        Text("Count (\(self.tracksCount))")
                            .tag(Tracks.count(self.tracksCount))
                        Text("Fixed (\(Int(self.tracksFixed)))")
                            .tag(Tracks.fixed(self.tracksFixed))
                        Text("Min (\(Int(self.tracksMin)))")
                            .tag(Tracks.min(self.tracksMin))
                    }
                }
                
                Section(header: Text("Spacing (\(Int(self.style.spacing)))")) {
                    Slider(value: self.$style.spacing, in: 0...32)
                }
            }
            .navigationBarTitle("Staggered Style")
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

struct StaggeredGridSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        StaggeredGridSettingsView(style: .constant(StaggeredGridStyle(tracks: 3)))
    }
}
