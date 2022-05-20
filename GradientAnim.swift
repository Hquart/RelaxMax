//
//  GradientAnim.swift
//  StarGates
//
//  Created by Naji Achkar on 12/05/2022.
//

import SwiftUI

struct GradientAnim: View {
    @State private var progress: CGFloat = 0
    
    let color1: Color
    let color2: Color
    let color3: Color
    let color4: Color
    
    init(color1: Color, color2: Color, color3: Color, color4: Color) {
        self.color1 = color1
        self.color2 = color2
        self.color3 = color3
        self.color4 = color4
    }
     
        var body: some View {
            Rectangle()
                .animatableGradient(fromGradient: Gradient(colors: [color1, color2]),
                                    toGradient: Gradient(colors: [color3, color4]),
                                         progress: progress)
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.linear(duration: 10.0).repeatForever(autoreverses: true)) {
                        self.progress = 1.0
                    }
                }
        }
}


////////////////////////////////////////////////////////////////////////////////////////////////
//struct GradientAnim_Previews: PreviewProvider {
//    static var previews: some View {
//        GradientAnim()
//    }
//}
    ////////////////////////////////////////////////////////////////////////////////////////////////
    struct AnimatableGradientModifier: AnimatableModifier {
        let fromGradient: Gradient
        let toGradient: Gradient
        var progress: CGFloat = 0.0
     
        var animatableData: CGFloat {
            get { progress }
            set { progress = newValue }
        }
     
        func body(content: Content) -> some View {
            var gradientColors = [Color]()
     
            for i in 0..<fromGradient.stops.count {
                let fromColor = UIColor(fromGradient.stops[i].color)
                let toColor = UIColor(toGradient.stops[i].color)
     
                gradientColors.append(colorMixer(fromColor: fromColor, toColor: toColor, progress: progress))
            }
     
            return LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
     
        func colorMixer(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> Color {
            guard let fromColor = fromColor.cgColor.components else { return Color(fromColor) }
            guard let toColor = toColor.cgColor.components else { return Color(toColor) }
     
            let red = fromColor[0] + (toColor[0] - fromColor[0]) * progress
            let green = fromColor[1] + (toColor[1] - fromColor[1]) * progress
            let blue = fromColor[2] + (toColor[2] - fromColor[2]) * progress
     
            return Color(red: Double(red), green: Double(green), blue: Double(blue))
        }
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////
    extension View {
        func animatableGradient(fromGradient: Gradient, toGradient: Gradient, progress: CGFloat) -> some View {
            self.modifier(AnimatableGradientModifier(fromGradient: fromGradient, toGradient: toGradient, progress: progress))
        }
    }
