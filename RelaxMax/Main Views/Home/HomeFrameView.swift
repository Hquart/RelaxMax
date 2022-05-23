//
//  HomeFrameView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 20/05/2022.
//

import SwiftUI

struct HomeFrameView: View {

    @State private var progress: CGFloat = 0.0
    var frameHeight: Double
    var frameText: String
    
    var colors1: [Color]
    var colors2: [Color]

    var body: some View {
        ZStack {
            Rectangle()
                .onAppear {
                    withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                        self.progress = 10.0
                    }
                }
                .animatableGradient(fromGradient: Gradient(colors: colors1), toGradient: Gradient(colors: colors2), progress: progress)
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct HomeFrameView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFrameView(frameHeight: 5, frameText: "Test", colors1: [.white, .red], colors2: [.blue, .black])
    }
}
