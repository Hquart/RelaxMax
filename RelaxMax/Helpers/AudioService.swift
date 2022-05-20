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
                player.setVolume(volume, fadeDuration: fadeDuration)
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
    func nextTrack() {
        print("play next track")
    }
}























//class GSAudio: NSObject, AVAudioPlayerDelegate {
//
//    static let sharedInstance = GSAudio()
//
//    private override init() {}
//
//    var players = [NSURL:AVAudioPlayer]()
//    var duplicatePlayers = [AVAudioPlayer]()
//
//    func playSound (soundFileName: String) {
//
////        let soundFileNameURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: soundFileName, ofType: "aif", inDirectory:"Sounds")!)
//
//        let sound1 = Bundle.main.path(forResource: "sound2", ofType: "mp3")
//
//        if let player = players[soundFileNameURL] { //player for sound has been found
//
//            if player.isPlaying == false { //player is not in use, so use that one
//                player.prepareToPlay()
//                player.play()
//
//            } else { // player is in use, create a new, duplicate, player and use that instead
//
//                let duplicatePlayer = try! AVAudioPlayer(contentsOfURL: soundFileNameURL)
//                //use 'try!' because we know the URL worked before.
//
//                duplicatePlayer.delegate = self
//                //assign delegate for duplicatePlayer so delegate can remove the duplicate once it's stopped playing
//
//                duplicatePlayers.append(duplicatePlayer)
//                //add duplicate to array so it doesn't get removed from memory before finishing
//
//                duplicatePlayer.prepareToPlay()
//                duplicatePlayer.play()
//
//            }
//        } else { //player has not been found, create a new player with the URL if possible
//            do{
//                let player = try AVAudioPlayer(contentsOfURL: soundFileNameURL)
//                players[soundFileNameURL] = player
//                player.prepareToPlay()
//                player.play()
//            } catch {
//                print("Could not play sound file!")
//            }
//        }
//    }
//
//
//    func playSounds(soundFileNames: [String]){
//
//        for soundFileName in soundFileNames {
//            playSound(soundFileName)
//        }
//    }
//
//    func playSounds(soundFileNames: String...){
//        for soundFileName in soundFileNames {
//            playSound(soundFileName)
//        }
//    }
//
//    func playSounds(soundFileNames: [String], withDelay: Double) { //withDelay is in seconds
//        for (index, soundFileName) in soundFileNames.enumerate() {
//            let delay = withDelay*Double(index)
//            let _ = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: #selector(playSoundNotification(_:)), userInfo: ["fileName":soundFileName], repeats: false)
//        }
//    }
//
//     func playSoundNotification(notification: NSNotification) {
//        if let soundFileName = notification.userInfo?["fileName"] as? String {
//             playSound(soundFileName)
//         }
//     }
//
//     func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
//        duplicatePlayers.removeAtIndex(duplicatePlayers.indexOf(player)!)
//        //Remove the duplicate player once it is done
//    }
//
//}



