//
//  FocusViewModel.swift
//  StarGates
//
//  Created by Naji Achkar on 17/05/2022.
//

import Foundation

class FocusViewViewModel: ObservableObject {
    
    @Published var breakDuration: Double = 900 // in seconds
    @Published var breakGap: Double = 100
    
    @Published var quoteText: String = """
                    Focus on one task at a time
                    Don't multitask
                    """
    
    @Published var breakMessageText: String = """
                    Time to take a break
                    Walk a little,
                    Get some fresh air, 
                    Drink water
                    """
    
    
    var breakDurationOptions = ["10 mn", "15 mn", "20 mn", "Test"]
    var breakGapOptions = ["45 mn", "60 mn", "90 mn", "Test"]
    
  
    
////////////////////////////////////////////////////////////////////////////////////////////////
    func setBreakDuration(index: Int) {
        switch index {
        case 0: self.breakDuration = 10 * 60
        case 1: self.breakDuration = 15 * 60
        case 2: self.breakDuration = 20 * 60
        case 3: self.breakDuration = 10
        default: self.breakDuration = 15 * 60
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func setBreakGap(index: Int) {
        switch index {
        case 0: self.breakGap = 45 * 60
        case 1: self.breakGap = 60 * 60
        case 2: self.breakGap = 90 * 60
        case 3: self.breakGap = 10
        default: self.breakGap = 60 * 60
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
//    func fadeVolumeAndPause(player: AudioPlayer) {
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//            player.setVolume(T##Float)
//            if player.volume == 0 {
//                self.player.stop()
//                timer.invalidate()
//            }
//        }
//    }
    

}
