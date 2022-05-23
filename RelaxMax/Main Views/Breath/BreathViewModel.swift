//
//  BreathViewModel.swift
//  RelaxMax
//
//  Created by Naji Achkar on 21/05/2022.
//

import Foundation

class BreathViewModel: ObservableObject {
    
    @Published var breathCount: Int = 12
    
    var breathDurationOptions = ["1 mn", "3 mn", "5 mn", "Test"]
    
    func setBreathDuration(index: Int) {
        switch index {
        case 0: self.breathCount = 12
        case 1: self.breathCount = 36
        case 2: self.breathCount = 60
        case 3: self.breathCount = 2
        default: self.breathCount = 2
        }
    }
}
