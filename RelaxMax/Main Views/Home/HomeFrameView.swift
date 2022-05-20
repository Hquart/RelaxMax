//
//  HomeFrameView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 20/05/2022.
//

import SwiftUI

struct HomeFrameView: View {

    @Binding var progress: CGFloat
    var frameHeight: Double
    var frameText: String
    
    var colors: [Color]

    var body: some View {
        ZStack {
            Rectangle()
//                .onAppear {
//                    withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
//                        self.progress = 0.0
//                    }
//                }
//                .animatableGradient(fromGradient: <#T##Gradient#>, toGradient: <#T##Gradient#>, progress: <#T##CGFloat#>)
                .frame(width: UIScreen.main.bounds.size.width/1.2, height: UIScreen.main.bounds.size.height/frameHeight)
                .cornerRadius(40)

            Text(frameText)
                .foregroundColor(.white)
                .bold()
                .font(.title)
                .frame(alignment: .topTrailing)
        }
    }

}

//struct HomeFrameView: View {
//
//    @Binding var progress: CGFloat
//    var frameHeight: Double
//    var frameText: String
//
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 40)
//                .animatableGradient(fromGradient: Gradient(colors: [.yellow, .orange]),
//                                    toGradient: Gradient(colors: [.pink, .purple]),
//                                    progress: progress)
//                .onAppear {
//                    withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: true)) {
//                        self.progress = 1.0
//                    }
//                }
//                .frame(width: UIScreen.main.bounds.size.width/1.2, height: UIScreen.main.bounds.size.height/frameHeight)
//                .cornerRadius(40)
//
//            Text(frameText)
//                .foregroundColor(.white)
//                .bold()
//                .font(.title)
//                .frame(alignment: .topTrailing)
//        }
//    }
//
//}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct HomeFrameView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFrameView(progress: .constant(0), frameHeight: 5, frameText: "Test", colors: [.red, .blue, .white, .purple])
    }
}
