//
//  BreathGradientView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 03/06/2022.
//

import SwiftUI


struct BreathGradientView: View {
    
    @Binding var progress: CGFloat
    @Binding var animate: Bool
    
        var body: some View {
            ZStack {
            Rectangle()
                .animatableGradient(fromGradient: Gradient(colors: [Color.breathGreen2, Color.breathGreen1]),
                                    toGradient: Gradient(colors: [Color.red, Color.blue]),
                                         progress: progress)
                .ignoresSafeArea()
                .animation(.linear(duration: 5.0).repeat(while: animate), value: animate)

        }
        }
}

struct BreathGradientView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BreathGradientView(progress: .constant(0.0), animate: .constant(true)).ignoresSafeArea()
        }
        .previewDevice("iPhone 13")
    }
}
