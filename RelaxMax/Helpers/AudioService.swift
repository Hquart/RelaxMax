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
    
    static let shared = AVAudioSession.sharedInstance()
    
    init(name: String, type: String, volume: Float = 1, fadeDuration: Double) {
        if let url = Bundle.main.url(forResource: name, withExtension: type) {
            print("success audio file: \(name)")
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
//                player.setVolume(volume, fadeDuration: fadeDuration)
                player.numberOfLoops = 0
            } catch {
                print ("error getting audio \(error.localizedDescription)")
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func playAudio() {
        player.play()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func pauseAudio() {
        player.pause()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func isPlayingAudio() -> Bool {
        return player.isPlaying
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func stopAudio() {
        player.stop()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func nextTrack() {
        print("play next track")
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func transitionSound() {
        
        
        
        player.setVolume(0.0, fadeDuration: 5.0)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
//    func fadeVolumeAndPause(player: AVAudioPlayer) {
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//            player.volume -= 1
//            if player.volume == 0 {
//                timer.invalidate()
//            }
//        }
//    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
}

