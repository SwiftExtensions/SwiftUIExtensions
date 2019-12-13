import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Layouts")) {
                    NavigationLink(destination: ModularGridView()) {
                        HStack {
                            Image(systemName: "square.grid.3x2.fill")
                            Text("Modular Grid")
                        }
                    }
                    
                    NavigationLink(destination: StaggeredGridView()) {
                        HStack {
                            Image(systemName: "rectangle.3.offgrid.fill")
                            Text("Staggered Grid")
                        }
                    }
                }
                
                Section(header: Text("Data Visualization")) {
                    NavigationLink(destination: ChartsView()) {
                        HStack {
                            Image(systemName: "chart.pie.fill")
                            Text("Charts")
                        }
                    }
                }
                
                
                Section(header: Text("Sliders")) {
                    NavigationLink(destination: HorizontalSliderExamplesView()) {
                        HStack {
                            Image(systemName: "square.split.1x2.fill")
                            Text("Horizontal")
                        }
                    }
                    
                    NavigationLink(destination: VerticalSliderExamplesView()) {
                        HStack {
                            Image(systemName: "square.split.2x1.fill")
                            Text("Vertical")
                        }
                    }
                    
                    NavigationLink(destination: PointSliderExamplesView()) {
                        HStack {
                            Image(systemName: "square.split.2x2.fill")
                            Text("Point")
                        }
                    }
                }
                
                Section(header: Text("Shapes")) {
                    NavigationLink(destination: RegularPolygonsView()) {
                        HStack {
                            Image(systemName: "square.fill")
                            Text("Regular Polygons")
                        }
                    }
                    
                    NavigationLink(destination: LinesView()) {
                        HStack {
                            Image(systemName: "pencil.and.outline")
                            Text("Lines")
                        }
                    }
                    
                    NavigationLink(destination: PatternsView()) {
                        HStack {
                            Image(systemName: "rectangle.split.3x3.fill")
                            Text("Patterns")
                        }
                    }
                }
            }
            .listStyle(
                GroupedListStyle()
            )
            .navigationBarTitle(Text("SwiftUI Extensions"))
        }
        .navigationViewStyle(
            StackNavigationViewStyle()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
