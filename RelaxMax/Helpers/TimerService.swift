//
//  TimerManager.swift
//  StarGates
//
//  Created by Naji Achkar on 17/05/2022.
//

import Foundation
import SwiftUI


enum timerMode {
    case running
    case stopped
    case paused
}

class TimerService: ObservableObject {
    
    @Published var mode: timerMode = .stopped
    @Published var secondsElapsed = 0.0
    
    var timer = Timer()
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { timer in
            self.secondsElapsed = self.secondsElapsed + 1
        }
    }
    
    func pause() {
        timer.invalidate()
        mode = .paused
    }
    
    func stop() {
        timer.invalidate()
        secondsElapsed = 0
        mode = .stopped
    }
    
}
