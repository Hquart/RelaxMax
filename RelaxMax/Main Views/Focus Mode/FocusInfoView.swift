//
//  FocusInfoView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 24/05/2022.
//

import SwiftUI

struct FocusInfoView: View {
    
    @State private var infoText = """
Focus mode helps you concentrate
on your work with white noise

Select break time and intervals

Get break notification in music

Get a motivating quote at break
"""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.orange, .blue], startPoint: .center, endPoint: .bottom)
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

struct FocusInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FocusInfoView()
    }
}
