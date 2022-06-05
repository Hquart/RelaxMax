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
                .animatableGradient(fromGradient: Gradient(colors: [Color.breathGreen1, Color.breathGreen2]),
                                    toGradient: Gradient(colors: [Color.red, Color.blue]),
                                         progress: progress)
                .ignoresSafeArea()
                .animation(.linear(duration: 5.0).repeat(while: animate), value: animate)
                
//                Button("Button") {
//                    withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
//                    progress = 1.0
//                }
//                }
                
        }
        }
}

//struct BreathGradientView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            BreathGradientView(progress: .constant(<#T##value: CGFloat##CGFloat#>), animate: .constant(true)).ignoresSafeArea()
//        }
//    }
//}
