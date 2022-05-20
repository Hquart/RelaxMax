
//  RelaxView.swift
//  StarGates
//
//  Created by Naji Achkar on 11/05/2022.
//

import SwiftUI

struct RelaxView: View {
    
    @ObservedObject var player2 = AudioPlayer(name: "relax1", type: "mp3", volume: 0.5, fadeDuration: 5.0)
    
    @State private var quote = """
    Tension is who you think you should be.
    Relaxation is who you are.
    """
    
    var body: some View {
        ZStack {
            GradientAnim(color1: .blue, color2: .purple, color3: .pink, color4: .white)
                .opacity(0.9)
                .ignoresSafeArea()
            CirclesAnimationView().opacity(0.2)
            VStack {
                Spacer()
                Text(quote)
                    .italic()
                    .multilineTextAlignment(.center)
                    .font(.title3).opacity(0.6)
                    .foregroundColor(Color.white)
                Spacer()
//                PlayerAudioView()
            }
            
        }
        //        .onAppear(perform: player2.playAudio)
    }
}

struct RelaxView_Previews: PreviewProvider {
    static var previews: some View {
        RelaxView()
    }
}
