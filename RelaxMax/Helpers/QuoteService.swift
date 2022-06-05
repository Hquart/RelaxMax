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
    
    func getNewQuote(from: String) {
        
         let quotes: [Quote] = Bundle.main.decode(from)

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
