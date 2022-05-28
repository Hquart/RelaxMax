//
//  BreathInfoView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 24/05/2022.
//

import SwiftUI

struct BreathInfoView: View {
    
    @State private var infoText = """
Have a deep breath for relaxation
based on the cardiac coherence method

Inhale and exhale deeply every 5 seconds

Let the flower animation guide you

Or close your eyes and rely on sounds and haptic feedback

An inspiring quote is waiting for you
when you finish
"""
    
    var body: some View {
        GeometryReader { geo in
        ZStack {
            LinearGradient(colors: [.purple, .gray], startPoint: .center, endPoint: .bottom)
                .ignoresSafeArea()
            
        VStack {
        Text(infoText)
                .foregroundColor(Color.white)
                .font(.headline)
                .italic()
                .multilineTextAlignment(.center)
        }
        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.6, alignment: .center)
    }
    }
}
}
struct BreathInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BreathInfoView()
    }
}
