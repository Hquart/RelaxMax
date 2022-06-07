//
//  PlayerAudioView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 20/05/2022.
//

import SwiftUI

struct PlayerAudioView: View {
    
    @Binding var isPlaying: Bool
    
   var player: AudioPlayer
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: {
                isPlaying ? player.pauseAudio() : player.playAudio(duration: 1.0)
                isPlaying.toggle()
            }) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.white).opacity(0.2)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 3)
                    .padding()
            }

        }.opacity(0.5)
    }
}
