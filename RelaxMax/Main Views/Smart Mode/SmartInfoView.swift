//
//  SmartInfoView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 25/05/2022.
//

import SwiftUI

import SwiftUI

struct SmartInfoView: View {
    
    @State private var infoText = """
    Smart Mode
    provides sounds effects
    automatically for you
    throughout the day
    based on your location, heartrate...
    """
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gray, .blue], startPoint: .center, endPoint: .bottom)
                .ignoresSafeArea()
            
        VStack {
        Text(infoText)
                .font(.title)
                .multilineTextAlignment(.center)
        }
        .frame(width: 300, height: 600, alignment: .center)
    }
    }
}

struct SmartInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SmartInfoView()
    }
}

