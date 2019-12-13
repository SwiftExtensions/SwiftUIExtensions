import SwiftUI
import SwiftUIExtensions

struct HorizontalSliderExamplesView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ScrollView {
            Group {
                
                HSlider(value: $model.value1)
                
//                ValueSlider(value: $model.value1)
//                    .background(Color.yellow)
//                    .valueSliderStyle(
//                        HorizontalValueSliderStyle(
//                            track: { HorizontalValueTrack(value: $0) },
//                            thumbSize: CGSize(width: 32, height: 32),
//                            options: .interactiveTrack
//                        )
//                    )

                
                HSlider(value: $model.value2,
                    configuration: .init(
                        thumbSize: CGSize(width: 16, height: 32)
                    )
                )
                                    
                HSlider(value: $model.value3, track:
                    LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                        .frame(height: 8)
                        .cornerRadius(4)
                )

                HSlider(
                    value: $model.value4,
                    track:
                        HTrack(
                            value: model.value4,
                            view: Rectangle()
                                .foregroundColor(.green)
                                .frame(height: 8),
                            configuration: .init(
                                offsets: 8
                            )
                        )
                        .background(Color.white)
                        .frame(height: 8)
                        .cornerRadius(3)
                        .overlay(
                            Capsule().strokeBorder(Color.white.opacity(0.5), lineWidth: 1)
                        )
                        .animation(
                            .spring(response: 0.7, dampingFraction: 0.4)
                        ),
                    configuration: .init(
                        thumbSize: CGSize(width: 16, height: 16)
                    )
                    
                )

                HSlider(
                    value: $model.value5,
                    track:
                        LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing)
                            .frame(height: 6)
                            .cornerRadius(3),
                    configuration: .init(
                        thumbSize: CGSize(width: 48, height: 16)
                    )
                )

                HSlider(
                    value: $model.value6,
                    track:
                        ZStack {
                            HTrack(
                                value: model.value6,
                                view: Rectangle().foregroundColor(.white).opacity(0.2),
                                mask: Rectangle()
                            )
                            
                            HTrack(
                                value: model.value6,
                                view: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing).opacity(0.8),
                                mask: Rectangle()
                            )
                            .overlay(
                                Capsule().strokeBorder(Color.white.opacity(0.5), lineWidth: 2)
                            )
                            .animation(.easeInOut(duration: 1.0))
                        }
                        .background(Capsule().foregroundColor(Color.secondary.opacity(0.25)))
                        .frame(height: 32)
                        .cornerRadius(16),
                    thumb: EmptyView(),
                    configuration: .init(
                        options: .interactiveTrack,
                        thumbSize: .zero
                    )
                )
            }

            Group {
                HorizontalRangeSlider(range: $model.range1)
                
                HRangeSlider(
                    range: $model.range2,
                    track:
                        HRangeTrack(
                            range: model.range2,
                            view: Capsule().foregroundColor(.purple),
                            mask: Rectangle(),
                            configuration: .init(
                                lowerOffset: 32,
                                upperOffset: 48
                            )
                        )
                        .background(Capsule().foregroundColor(Color.purple.opacity(0.25)))
                        .frame(height: 8),
                    lowerThumb: Circle().foregroundColor(.purple),
                    upperThumb: Circle().foregroundColor(.purple),
                    configuration: .init(
                        thumbSize: CGSize(width: 32, height: 32)
                    )
                )
                
                HRangeSlider(
                    range: $model.range3,
                    track:
                        HRangeTrack(
                            range: model.range3,
                            view: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing),
                            configuration: .init(
                                offsets: 32
                            )
                        )
                        .background(LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing).opacity(0.25))
                        .frame(height: 32)
                        .cornerRadius(16),
                    lowerThumb: HalfCapsule().foregroundColor(.white).shadow(radius: 3),
                    upperThumb: HalfCapsule().rotation(Angle(degrees: 180)).foregroundColor(.white).shadow(radius: 3),
                    configuration: .init(
                        thumbSize: CGSize(width: 32, height: 32)
                    )
                )
                
                HRangeSlider(
                    range: $model.range4,
                    track:
                        HRangeTrack(
                            range: model.range4,
                            view: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing),
                            mask: Rectangle(),
                            configuration: .init(
                                offsets: 16
                            )
                        )
                        .mask(Ellipse())
                        .background(Ellipse().foregroundColor(Color.secondary.opacity(0.25)))
                        .overlay(Ellipse().strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                        .padding(.vertical, 8),
                    configuration: .init(
                        thumbSize: CGSize(width: 16, height: 64)
                    )
                )
                .frame(height: 64)
                
                HRangeSlider(
                    range: $model.range5,
                    in: 0.0...1.0,
                    step: 0.01,
                    track:
                        HRangeTrack(
                            range: model.range5,
                            view: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing),
                            mask: Rectangle(),
                            configuration: .init(
                                offsets: 32
                            )
                        )
                        .background(Color.secondary.opacity(0.25))
                        .cornerRadius(16),
                    lowerThumb: HalfCapsule().foregroundColor(.white).shadow(radius: 3),
                    upperThumb: HalfCapsule().rotation(Angle(degrees: 180)).foregroundColor(.white).shadow(radius: 3),
                    configuration: .init(
                        thumbSize: CGSize(width: 32, height: 64)
                    )
                    
                )
                .frame(height: 64)
                
                HRangeSlider(
                    range: $model.range6,
                    track: HRangeTrack(
                        range: model.range6,
                        view:
                            ZStack {
                                  LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                                  VStack {
                                      Text("Any View")
                                          .font(.largeTitle)
                                          .foregroundColor(Color.white)
                                      Text("Place any view here and it will be masked to a selected value range")
                                          .font(.title)
                                          .foregroundColor(Color.white.opacity(0.5))
                                  }
                            },
                        mask: RoundedRectangle(cornerRadius: 10),
                        configuration: .init(
                            offsets: 8
                        )
                    )
                    .background(Color.secondary.opacity(0.25)),
                    configuration: .init(
                        thumbSize: CGSize(width: 8, height: 64)
                    )
                )
                .cornerRadius(8)
                .frame(height: 128)
            }

        }
        .padding()
    }
}


struct HorizontalSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalSliderExamplesView().environmentObject(Model.preview)
    }
}
