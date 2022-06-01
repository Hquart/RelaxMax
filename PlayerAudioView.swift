//
//  PlayerAudioView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 20/05/2022.
//

import SwiftUI

struct PlayerAudioView: View {
    
    @Binding var isPlaying: Bool
//     var showNextButton: Bool
    @ObservedObject var player: AudioPlayer
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: {
                isPlaying ? player.pauseAudio() : player.playAudio()
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
//            if showNextButton {
//            Button(action: {
//                player.nextTrack()
//            }) {
//                Image(systemName: "chevron.right.2").resizable()
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(Color.black).opacity(0.2)
//                    .aspectRatio(contentMode: .fit)
//                    .shadow(radius: 3)
//                    .padding()
//            }
//            }
        }.opacity(0.5)
    }
}

//struct PlayerAudioView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerAudioView(isPlaying: .constant(false), showNextButton: false, player: <#AudioPlayer#>)
//    }
//}


struct MuteAudioView: View {
    
    @Binding var isPlaying: Bool
    @ObservedObject var player: AudioPlayer
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: {
                isPlaying ? player.muteAudio() : player.unMuteAudio()
                isPlaying.toggle()
            }) {
                Image(systemName: isPlaying ? "speaker.wave.3" : "speaker")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.black).opacity(0.5)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 3)
                    .padding()
            }
        }.opacity(0.4)
    }
}
