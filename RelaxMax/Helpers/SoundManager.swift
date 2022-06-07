//
//  SoundManager.swift
//  RelaxMax
//
//  Created by Naji Achkar on 05/06/2022.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
//    enum SoundOption: String {
//        case whiteNoise
//        case windNoise
//    }
    
   
    
    func playSound(track: String, loops: Int) {
        guard let url = Bundle.main.url(forResource: track, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = loops
            player?.play()
//            if fadeIn {
//                player?.setVolume(0.01, fadeDuration: 1)
//                player?.play()
//                var count: Double = 0.01
//                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//                    count += 0.01
//                    self.player?.setVolume(Float(count), fadeDuration: 1)
//                    if self.player?.volume == 1.0 {
//                        timer.invalidate()
//                    }
//                }
//            } else {
//
//            }
        }  catch let error {
        print ("error getting audio \(error.localizedDescription)")
    }
}
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
//    func fadeIn() {
//        player.setVolume(0.01, fadeDuration: 1)
//        player.play()
//        var count: Double = 0.01
//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//            count += 0.01
//            self.player.setVolume(Float(count), fadeDuration: 1)
//            if self.player.volume == 1.0 {
//                timer.invalidate()
//                self.volumeReachedMaximum = true
//            }
//        }
//    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func fadeOut()  {
        guard let playerToFade = self.player else { return }
         let currentVolume = playerToFade.volume
            
        
            playerToFade.setVolume(currentVolume, fadeDuration: 1)
        var count: Double = 1.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            count -= 0.01
            playerToFade.setVolume(Float(count), fadeDuration: 1)
            
            if playerToFade.volume < 0.01 {
                timer.invalidate()
                playerToFade.stop()
            }
        }
        
        playerToFade.currentTime = 0
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func fadeInAccomplished() -> Bool {
        return player?.volume == 1.0
    }
    
    func playAudio() {
        player?.play()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func pauseAudio() {
        player?.pause()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func muteAudio() {
        player?.setVolume(0.0, fadeDuration: 1)
    }
    
    func unMuteAudio() {
        player?.setVolume(1.0, fadeDuration: 1)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func isPlayingAudio() -> Bool {
        return ((player?.isPlaying) != nil)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func stopAudio() {
        player?.stop()
        player?.currentTime = 0
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func nextTrack() {
        print("play next track")
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
