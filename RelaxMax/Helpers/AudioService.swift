//
//  AudioManager.swift
//  StarGates
//
//  Created by Naji Achkar on 10/05/2022.
//

import Foundation
import AVFoundation

class AudioPlayer: ObservableObject {
    
    @Published var volumeReachedMaximum: Bool = false
    
    var player = AVAudioPlayer()
    
    static let shared = AVAudioSession.sharedInstance()
    
    init(name: String, type: String, volume: Float = 0, fadeDuration: Double, loops: Int) {
        if let url = Bundle.main.url(forResource: name, withExtension: type) {
            print("success audio file: \(name)")
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.numberOfLoops = loops
//                player.setVolume(0.01, fadeDuration: 1)
                
            } catch {
                print ("error getting audio \(error.localizedDescription)")
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func fadeIn() {
        player.setVolume(0.01, fadeDuration: 1)
        player.play()
        var count: Double = 0.01
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            count += 0.01
            self.player.setVolume(Float(count), fadeDuration: 1)
            print(self.player.volume)
            if self.player.volume == 1.0 {
                timer.invalidate()
                self.volumeReachedMaximum = true
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func fadeOut()  {
        let currentVolume = self.player.volume
        player.setVolume(currentVolume, fadeDuration: 1)
        var count: Double = 1.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            count -= 0.01
            self.player.setVolume(Float(count), fadeDuration: 1)
            print(self.player.volume)
            if self.player.volume < 0.01 {
                timer.invalidate()
                self.player.stop()
            }
        }
    }
    
    func fadeInAccomplished() -> Bool {
        return player.volume == 1.0
    }
    
    func playAudio() {
        player.play()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func pauseAudio() {
        player.pause()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func muteAudio() {
        player.setVolume(0.0, fadeDuration: 1)
    }
    
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
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func nextTrack() {
        print("play next track")
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
