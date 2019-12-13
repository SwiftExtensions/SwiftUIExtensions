import SwiftUI
import SwiftUIExtensions

struct PointSliderExamplesView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ScrollView {
            Group {
                XYSlider(
                    x: $model.pointX1,
                    y: $model.pointY1,
                    track:
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                            LinearGradient(gradient: Gradient(colors: [.white, .clear]), startPoint: .bottom, endPoint: .top).blendMode(.hardLight)
                        },
                    thumb:
                        Circle()
                            .foregroundColor(.white)
                            .shadow(radius: 3),
                    configuration: .init(
                        options: .interactiveTrack,
                        thumbSize: CGSize(width: 48, height: 48)
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .strokeBorder(lineWidth: 4)
                        .foregroundColor(Color.white)
                )
                .cornerRadius(24)
                .frame(height: 256)
                .shadow(radius: 3)
                .padding()
                
                HStack {
                    XYSlider(
                        x: $model.pointX2,
                        y: $model.pointY2,
                        track:
                        RoundedRectangle(cornerRadius: 24)
                            .foregroundColor(
                                Color(hue: 0.67, saturation: model.pointY2, brightness: 1.0)
                            ),
                        thumb:
                            ZStack {
                                Capsule().frame(width: 12).foregroundColor(.white)
                                Capsule().frame(height: 12).foregroundColor(.white)
                            }
                            .compositingGroup()
                            .rotationEffect(Angle(radians: model.pointX2 * 10))
                            .shadow(radius: 3),
                        configuration: .init(
                            options: .interactiveTrack,
                            thumbSize: CGSize(width: 48, height: 48)
                        )
                    )
                    .frame(height: 256)
                    .shadow(radius: 3)
                    .padding()
                    
                    XYSlider(
                        x: $model.pointX3,
                        y: $model.pointY3,
                        track:
                            ZStack {
                                  LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                                  VStack {
                                      Text("Any View")
                                          .font(.largeTitle)
                                          .foregroundColor(Color.white)
                                      Text("Place any view here")
                                          .font(.title)
                                          .foregroundColor(Color.white.opacity(0.5))
                                  }
                            }
                            .cornerRadius(24),
                        thumb:
                            Capsule()
                                .foregroundColor(.white)
                                .shadow(radius: 3),
                        configuration: .init(
                            options: .interactiveTrack,
                            thumbSize: CGSize(width: 96, height: 48)
                        )
                    )
                    .frame(height: 256)
                    .shadow(radius: 3)
                    .padding()
                }
                
                XYSlider(x: $model.pointX4, y: $model.pointY4)
                    .frame(height: 256)
                    .padding()
                
            }

        }
        .padding()
    }
}


struct PointSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        PointSliderExamplesView().environmentObject(Model.preview)
    }
}
