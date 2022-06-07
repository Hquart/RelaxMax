//
//  AudioManager.swift
//  StarGates
//
//  Created by Naji Achkar on 10/05/2022.
//

import Foundation
import AVFoundation

class AudioPlayer: ObservableObject {
    
    var player = AVAudioPlayer()
    
    init(name: String, type: String, volume: Float = 0, fadeDuration: Double, loops: Int) {
        if let url = Bundle.main.url(forResource: name, withExtension: type) {
            print("success audio file: \(name)")
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.numberOfLoops = loops
                player.setVolume(0.1, fadeDuration: 1)
                
            } catch {
                print ("error getting audio \(error.localizedDescription)")
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////
    func playAudio(duration: Double) {
        player.play()
        player.setVolume(1.0, fadeDuration: duration)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func pauseAudio() {
        player.pause()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func muteAudio() {
        player.setVolume(0.0, fadeDuration: 1)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func unMuteAudio() {
        player.setVolume(1.0, fadeDuration: 1)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func isPlayingAudio() -> Bool {
        return player.isPlaying 
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func stopAudio() {
        player.stop()
        player.currentTime = 0
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func nextTrack() {
        print("play next track")
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
