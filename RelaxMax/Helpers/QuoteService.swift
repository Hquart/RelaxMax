//
//  Quote.swift
//  RelaxMax
//
//  Created by Naji Achkar on 20/05/2022.
//

import Foundation
////////////////////////////////////////////////////////////////////////////////////////////////
class QuoteService: ObservableObject {
    
    @Published var current: String = ""
 
    init() {
        getNewQuote()
    }
    
    func getNewQuote() {
        
         let quotes: [Quote] = Bundle.main.decode("quotes.json")

        if let random = quotes.randomElement() {
            self.current = random.quoteText
        }
    }
    }
////////////////////////////////////////////////////////////////////////////////////////////////
struct Quote: Codable {

    let quoteText: String
    let quoteAuthor: String
    
}
////////////////////////////////////////////////////////////////////////////////////////////////
