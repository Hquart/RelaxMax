//
//  BreathViewModel.swift
//  RelaxMax
//
//  Created by Naji Achkar on 21/05/2022.
////
//
//import Foundation
//
//class BreathViewModel: ObservableObject {
//
//    var quoteService = QuoteService()
//    
//    @Published var selection: UUID?
//    @Published var breathDuration: Int = 10
//    @Published var quote: String = ""
//
//    @Published var breathDurationOptions = [OptionItem(minutes: 1),
//                                            OptionItem(minutes: 2),
//                                            OptionItem(minutes: 3),
//                                            OptionItem(minutes: 4),
//                                            OptionItem(minutes: 5),
//                                            OptionItem(minutes: 0)]
//
//    @Published var welcomeText = """
//Help your body and mind
//with regular breathing sessions
//"""
//    
//    
//    
//
//}
////////////////////////////////////////////////////////////////////////////////////////////////
//
//


//class BreathViewModel: ObservableObject {
//    
//    @Published var selection: UUID?
//    @Published var breathCount: Int = 2
//    
//    @Published var breathDurationOptions = [OptionItem(name: "1 mn"),
//                                            OptionItem(name: "2 mn"),
//                                            OptionItem(name: "3 mn"),
//                                            OptionItem(name: "4mn"),
//                                            OptionItem(name: "5 mn"),
//                                            OptionItem(name: "Test")]
//    
//    func setBreathDuration(index: Int) {
//        switch index {
//        case 0: self.breathCount = 12
//        case 1: self.breathCount = 24
//        case 2: self.breathCount = 36
//        case 3: self.breathCount = 48
//        case 4: self.breathCount = 60
//        case 5: self.breathCount = 2
//        default: self.breathCount = 2
//        }
//    }
//}
