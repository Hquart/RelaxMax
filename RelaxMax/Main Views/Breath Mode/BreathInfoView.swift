//
//  BreathInfoView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 24/05/2022.
//

import SwiftUI

struct BreathInfoView: View {
    
    @State private var infoText = """
Cardiac coherence method:

Inhale for 5 seconds,

Exhale for 5 seconds,


Lowers your blood pressure

Helps you relax or sleep
"""
    @State private var anim: Bool = false
    
    var body: some View {
        GeometryReader { geo in
        ZStack {
            LinearGradient(colors: [.white, .gray], startPoint: .center, endPoint: .bottom)
                .ignoresSafeArea()
            
        VStack {
            FlowerInfoView(animFlower: $anim, openFlower: $anim)
                .padding(.bottom, 100)
                .shadow(color: .blue, radius: 3)
        Text(infoText)
                .foregroundColor(Color.black)
                .font(.headline)
                .italic()
                .multilineTextAlignment(.center)
                .scaleEffect(1.2)
        }
        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.6, alignment: .center)
    }
    }
}
}
struct BreathInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BreathInfoView()
            .previewDevice("iPhone 13")
    }
}
