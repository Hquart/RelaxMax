//
//  Extension.swift
//  RelaxMax
//
//  Created by Naji Achkar on 20/05/2022.
//

import Foundation
import SwiftUI

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// EXTENSIONS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return loaded
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}


extension Color {
    static let appBlue = Color("appBlue")
    static let appWhite = Color("appWhite")
    static let appGray = Color("appGray")
    static let appDarkGray = Color("appDarkGray")
    static let appGreen = Color("appGreen")
    static let appDarkBlue = Color("appDarkBlue")
    static let appLightBlue = Color("appLightBlue")
    static let appRed = Color("appRed")
    static let appOrange = Color("appOrange")
    static let flowerColor = Color("flowerColor")
}

